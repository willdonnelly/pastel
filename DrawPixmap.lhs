> module DrawPixmap
>     ( drawPixmap
>     ) where

> import Types
> import DrawUtils
> import Numeric
> import Data.Maybe
> import Data.List
> import Data.Array

> hexOut :: Int -> Int -> String
> hexOut l x = pad ++ hex
>     where pad = replicate (l - (length hex)) '0'
>           hex = showHex x ""

> drawPixmap :: (Int, Int) -> Drawing -> String
> drawPixmap (width, height) drawing = unlines $ concat [[magic], [header], palette, image]
>     where magic = "! XPM2"
>           header = unwords $ map show [width, height, pSize, indexSize]
>           palette = map paletteLine $ assocs pLookup
>               where paletteLine (i,c) = hexOut indexSize i ++ " c #" ++ hexOut 6 c
>           image = map imageLine pImage
>               where imageLine xs = concat $ map (hexOut indexSize) xs
>           indexSize = ceiling $ log (succ $ fromIntegral pSize) / (8 * log 2)
>           (pImage, pLookup, pSize) = palettize $ intImage $ pointField (width, height) drawing

> splitLength x = takeWhile (not . null) . unfoldr (Just . splitAt x)
