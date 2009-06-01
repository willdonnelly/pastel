> module DrawAscii
>     ( drawAscii
>     ) where

> import Types
> import Data.List
> import DrawUtils

 drawAscii :: (Int, Int) -> Drawing -> String

> drawAscii (width, height) drawing = unlines $ map (map ascii) $ points
>     where points = pointField (width, height) drawing
>           ascii (Point a c) = if (asRGB c) == (RGB 0 0 0)
>                                  then '.'
>                                  else '#'
