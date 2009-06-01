> module Main where
> import Colors
> import Types
> import DrawAscii
> import DrawPixmap
> import Shapes

> main = do
>     putStr $ drawPixmap (1024, 1024) $ circle $ canvas black
