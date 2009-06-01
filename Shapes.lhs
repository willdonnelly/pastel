> module Shapes
>     ( circle
>     , canvas
>     ) where

> import Types
> import Colors

> circle :: Drawing -> Drawing
> circle f (x,y) = if x*x + y*y < 1.0
>                     then white
>                     else f (x,y)

> canvas :: Point -> Drawing
> canvas c (x,y) = c
