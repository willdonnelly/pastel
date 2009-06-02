> module DrawPng
>     ( drawPng
>     ) where

> import DrawUtils
> import Types

> drawPng :: Drawing -> String
> drawPng = signature
>     where signature = "\x89PNG\r\n\x1a\n"
