> module Main where
> import Colors
> import Types
> import DrawAscii
> import Shapes

> main = do
>     putStrLn $ drawAscii (11, 11) $ circle $ canvas black
