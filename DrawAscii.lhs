> module DrawAscii
>     ( drawAscii
>     ) where

> import Types
> import Data.List

> drawAscii :: (Int, Int) -> Drawing -> String
> drawAscii (width, height) drawing = unlines $ map (drawLine drawing) $ reverse $ evenInterval height
>     where drawLine drawing x = intersperse ' ' $ map ascii $ map drawing $ lineIdxs x
>           lineIdxs x = zip (evenInterval width) $ repeat x
>           ascii (Point a c) = if (asRGB c) == (RGB 0 0 0)
>                                  then '.'
>                                  else '#'

> evenInterval :: Int -> [Float]
> evenInterval n = map (scale . shift) $ take n [0..]
>     where shift x = x - (n `div` 2)
>           scale x = (fromIntegral (x * 2)) / (fromIntegral n)
