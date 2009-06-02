> module Graphics.Pastel.Primitives
>     ( circle
>     , canvas
>     ) where

> import Graphics.Pastel.Types
> import Graphics.Pastel.Colors

> circle :: Drawing -> Drawing
> circle f (x,y) = if x*x + y*y < 1.0
>                     then purple
>                     else f (x,y)

> canvas :: Color -> Drawing
> canvas c (x,y) = c
