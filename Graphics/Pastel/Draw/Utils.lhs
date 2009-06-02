> module Graphics.Pastel.Draw.Utils
>    ( colorField, intField
>    , colorToInt, intToColor
>    , evenInterval
>    , palettize
>    ) where

> import Graphics.Pastel

> import Data.List
> import Data.Array
> import Data.Bits

> colorField :: (Int, Int) -> Drawing -> [[Color]]
> colorField (width, height) drawing = map pixelLine $ evenInterval height
>     where pixelLine x = map drawing $ indices x
>           indices x = zip (evenInterval width) $ repeat x

> intField :: (Int, Int) -> Drawing -> [[Int]]
> intField (w,h) d = map (map colorToInt) $ colorField (w,h) d

> colorToInt :: Color -> Int
> colorToInt (RGB r g b) = r' .|. g' .|. b'
>     where r' = (truncate $ r * 0xFF) `shiftL` 16
>           g' = (truncate $ g * 0xFF) `shiftL` 8
>           b' = (truncate $ b * 0xFF)

> intToColor :: Int -> Color
> intToColor x = RGB r g b
>     where r = (/0xFF) $ fromIntegral $ x .&. 0xFF0000 `shiftR` 16
>           g = (/0xFF) $ fromIntegral $ x .&. 0x00FF00 `shiftR` 8
>           b = (/0xFF) $ fromIntegral $ x .&. 0x0000FF

> evenInterval :: Int -> [Float]
> evenInterval n = map (scale . shift) $ take n [0..]
>     where shift x = x - (n `div` 2)
>           scale x = (fromIntegral (x * 2)) / (fromIntegral n)

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
