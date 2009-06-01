> module DrawUtils
>    ( pointField
>    , pixelToInt
>    , intImage
>    , palettize
>    , evenInterval
>    ) where

> import Data.List
> import Types

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

> intImage :: [[Point]] -> [Int]
> intImage ps = concat $ map (map pixelToInt) ps

> palettize :: Int -> [Int] -> ([Int], [Int])
> palettize paletteSize imageData = (map closest imageData, palette)
>     where palette = take paletteSize $ snd $ unzip $ reverse $ sort $ map listLength $ group $ sort imageData
>           closest n = foldl1 (takeCloser n) palette
>           takeCloser n x y = if (abs $ n - x) < (abs $ n - y)
>                                 then x
>                                 else y
>           listLength xs = (length xs, head xs)
