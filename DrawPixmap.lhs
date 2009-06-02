> module DrawPixmap
>     ( drawPixmap
>     ) where

> import Types
> import DrawUtils
> import Numeric
> import Data.Maybe
> import Data.List
> import Data.Array

> padString :: Char -> Int -> String -> String
> padString c l s = (replicate (l - (length s)) c) ++ s

> hexOut :: Int -> Int -> String
> hexOut l x = padString '0' l $ showHex x ""

> drawPixmap :: (Int, Int) -> Drawing -> String
> drawPixmap (width, height) drawing = header ++ paletteHeader ++ imgData
>     where header = "! XPM2\n" ++ show width ++ " " ++ show height ++ " " ++ (show paletteSize) ++ " " ++ show indexSize ++ "\n"
>           (palettized, palette, paletteSize) = palettize $ intImage $ pointField (width, height) drawing
>           indexSize = ceiling $ log ((fromIntegral paletteSize) + 1) / (8 * log 2)
>           paletteHeader = unlines $ map paletteLine $ assocs palette
>           paletteLine (i,c) = (hexOut indexSize i) ++ " c #" ++ (hexOut 6 c)
>           imgData = unlines $ map concat $ map (map (hexOut indexSize)) $ palettized

> splitLength x = takeWhile (not . null) . unfoldr (Just . splitAt x)
