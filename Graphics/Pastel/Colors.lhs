> module Graphics.Pastel.Colors
>     ( darkRed, lightRed, red
>     , darkOrange, lightOrange, orange
>     , darkYellow, lightYellow, yellow
>     , darkGreen, lightGreen, green
>     , darkBlue, lightBlue, blue
>     , darkPurple, lightPurple, purple
>     , darkGrey, lightGrey, grey
>     , black, white
>     ) where

> import Graphics.Pastel.Types

These types don't come from any definition. I started looking
for one, but ended up concluding it would be faster just to
play around with RGB values until I got some I liked.

> darkRed     = RGB 0.5 0.0 0.0
> lightRed    = RGB 1.0 0.4 0.7
> red         = RGB 1.0 0.0 0.0
> darkOrange  = RGB 0.9 0.6 0.0
> lightOrange = RGB 1.0 0.8 0.3
> orange      = RGB 1.0 0.8 0.0
> darkYellow  = RGB 0.7 0.7 0.0
> lightYellow = RGB 1.0 1.0 0.3
> yellow      = RGB 1.0 1.0 0.0
> darkGreen   = RGB 0.0 0.7 0.0
> lightGreen  = RGB 0.3 1.0 0.3
> green       = RGB 0.0 1.0 0.0
> darkBlue    = RGB 0.0 0.1 0.5
> lightBlue   = RGB 0.3 0.8 1.0
> blue        = RGB 0.0 0.0 1.0
> darkPurple  = RGB 0.3 0.0 0.6
> lightPurple = RGB 0.7 0.4 1.0
> purple      = RGB 0.6 0.0 1.0
> darkGrey    = RGB 0.3 0.3 0.3
> lightGrey   = RGB 0.7 0.7 0.7
> grey        = RGB 0.5 0.5 0.5
> black       = RGB 0.0 0.0 0.0
> white       = RGB 1.0 1.0 1.0
