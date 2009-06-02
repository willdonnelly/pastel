> module Graphics.Pastel.Draw.Utils
>    ( pointField
>    , evenInterval
>    , pixelToInt
>    , intImage
>    , palettize
>    ) where

> import Data.List
> import Data.Array
> import Graphics.Pastel.Types

> pointField :: (Int, Int) -> Drawing -> [[Point]]
> pointField (width, height) drawing = map pixelLine $ evenInterval height
>     where pixelLine x = map drawing $ indices x
>           indices x = zip (evenInterval width) $ repeat x

> evenInterval :: Int -> [Float]
> evenInterval n = map (scale . shift) $ take n [0..]
>     where shift x = x - (n `div` 2)
>           scale x = (fromIntegral (x * 2)) / (fromIntegral n)

> pixelToInt :: Point -> Int
> pixelToInt (Point a (RGB r g b)) = truncate $ r*256*256*255 + g*256*255 + b*255
> pixelToInt (Point a (BnW v))     = truncate $ v*256*256*255 + v*256*255 + v*255

> intImage :: [[Point]] -> [[Int]]
> intImage = map (map pixelToInt)

> palettize :: [[Int]] -> ([[Int]], Array Int Int, Int)
> palettize image = (map (map convPal) image, lookups, succ nColors)
>     where lookups = listArray (0,nColors) palette
>           nColors = pred $ length palette
>           palette = nub $ concat image
>           convPal x = binarySearch lookups (0, nColors) x

> binarySearch :: Array Int Int -> (Int, Int) -> Int -> Int
> binarySearch array (min, max) value
>     | not $ inRange (bounds array) $ min = error "Minimum array index out of range."
>     | not $ inRange (bounds array) $ max = error "Maximum array index out of range."
>     | not $ inRange (bounds array) $ mid = error "Midpoint array index out of range."
>     | array ! min == value = min
>     | array ! max == value = max
>     | otherwise = case array ! mid `compare` value of
>                        EQ -> mid
>                        LT -> binarySearch array (min, pred mid) value
>                        GT -> binarySearch array (succ mid, max) value
>     where mid = (min + max) `div` 2
