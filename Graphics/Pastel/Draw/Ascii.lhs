> module Graphics.Pastel.Draw.Ascii
>     ( drawAscii
>     ) where

> import Graphics.Pastel.Draw.Utils
> import Graphics.Pastel.Types

> import Data.List

> drawAscii (width, height) drawing = unlines $ map (map ascii) $ points
>     where points = pointField (width, height) drawing
>           ascii (Point a c) = if (asRGB c) == (RGB 0 0 0)
>                                  then '.'
>                                  else '#'
