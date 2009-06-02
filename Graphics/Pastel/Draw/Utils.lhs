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

> palettize :: [[Int]] -> ([[Int]], [(Int, Int)], Int)
> palettize image = (breakUp $ out, table, num)
>     where (out, table, num) = handScan $ concat image
>           width = length $ head image
>           breakUp = takeWhile (not . null) . unfoldr (Just . splitAt width)

The table is a list of (index, color) pairs, despite what
a casual reading of the source might imply. Notice the
map in the output function reverses the pairs.

> handScan :: [Int] -> ([Int], [(Int, Int)], Int)
> handScan xs = output $ foldl scanElem ([], [], 0) xs

> scanElem (out, table, num) x =
>               case x `lookup` table of
>                    Nothing -> (num:out, (x,num):table, succ num)
>                    Just y  -> (y:out, table, num)
> output (out, table, num) =
>               (reverse out, sort $ map (\(x,y) -> (y,x)) table, num)
