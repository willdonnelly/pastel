> module Main where
> import Colors
> import Types
> import DrawAscii
> import DrawPixmap
> import Shapes

> main = do
>     putStr $ drawPixmap (128, 128) $ circle $ canvas black
