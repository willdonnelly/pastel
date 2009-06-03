> module Main where

> import Graphics.Pastel
> import Graphics.Pastel.Runners.XPM

> main = runXPM (500,500) $ zoom 4 $ circle purple $ zoom 0.5 $ gradientLinear blue $ gradientRadial green $ canvas white
