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

> darkRed     = RGB 0xAA 0x00 0x00
> lightRed    = RGB 0xFF 0x44 0x44
> red         = RGB 0xFF 0x00 0x00
> darkOrange  = RGB 0xDD 0x55 0x00
> lightOrange = RGB 0xFF 0xAA 0x44
> orange      = RGB 0xFF 0x77 0x00
> darkYellow  = RGB 0xCC 0xCC 0x00
> lightYellow = RGB 0xFF 0xFF 0x77
> yellow      = RGB 0xFF 0xFF 0x00
> darkGreen   = RGB 0x00 0x88 0x00
> lightGreen  = RGB 0x77 0xFF 0x00
> green       = RGB 0x00 0xFF 0x00
> darkBlue    = RGB 0x00 0x00 0x77
> lightBlue   = RGB 0x00 0x77 0xFF
> blue        = RGB 0x00 0x00 0xFF
> darkPurple  = RGB 0x44 0x00 0x88
> lightPurple = RGB 0xAA 0x55 0xFF
> purple      = RGB 0x88 0x00 0xFF
> darkGrey    = RGB 0x44 0x44 0x44
> lightGrey   = RGB 0xAA 0xAA 0xAA
> grey        = RGB 0x77 0x77 0x77
> black       = RGB 0x00 0x00 0x00
> white       = RGB 0xFF 0xFF 0xFF
