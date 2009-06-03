> module Graphics.Pastel.Draw.Utils
>    ( colorField, intField
>    , colorToInt, intToColor
>    , evenInterval
>    , palettize
>    ) where

> import Graphics.Pastel

> import Data.List
> import qualified Data.Map as Map
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

> palettize :: [[Int]] -> ([[Int]], [(Int, Int)], Int)
> palettize image = (breakUp out, table, num)
>     where (out, table, num) = paletteConvert $ concat image
>           width = length $ head image
>           breakUp = takeWhile (not . null) . unfoldr (Just . splitAt width)

> paletteConvert :: [Int] -> ([Int], [(Int, Int)], Int)
> paletteConvert xs = output $ foldl paletteFold ([], Map.empty, 0) xs

> paletteFold :: ([Int], Map.Map Int Int, Int) -> Int -> ([Int], Map.Map Int Int, Int)
> paletteFold (output, table, number) value =
>     case value `Map.lookup` table of
>          Nothing -> (number:output, Map.insert value number table, succ number)
>          Just ix -> (ix:output, table, number)

> output :: ([Int], Map.Map Int Int, Int) -> ([Int], [(Int, Int)], Int)
> output (output, table, number) = (reverse output, reversePairs $ Map.assocs table, number)
>     where reversePairs = map (\(x,y) -> (y,x))
