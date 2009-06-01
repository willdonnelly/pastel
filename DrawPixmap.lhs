> module DrawPixmap
>     ( drawPixmap
>     ) where

> import Types
> import DrawUtils
> import Numeric
> import Data.Maybe
> import Data.List

> padString :: Char -> Int -> String -> String
> padString c l s = (replicate (l - (length s)) c) ++ s

> drawPixmap :: (Int, Int) -> Drawing -> String
> drawPixmap (width, height) drawing = header ++ paletteHeader ++ imgData
>     where header = "! XPM2\n" ++ show width ++ " " ++ show height ++ " " ++ (show $ length paletteColors) ++ " 2\n"
>           paletteHeader = unlines $ map paletteLine paletteLookup
>           paletteLine (c, i) = (padString '0' 2 $ showHex i "") ++ " c #" ++ (padString '0' 6 $ showHex c "")
>           paletteLookup = zip paletteColors [0..]
>           paletteGet x = padString '0' 2 $ showHex (fromJust $ lookup x paletteLookup) ""
>           imgData = unlines $ map (concat . (map paletteGet)) $ splitLots width $ points
>           (points, paletteColors) = palettize 256 $ intImage $ pointField (width, height) drawing

> splitLots x = takeWhile (not . null) . unfoldr (Just . splitAt x)
