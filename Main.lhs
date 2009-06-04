> module Main where

> import Graphics.Pastel
> import Graphics.Pastel.Runners.FakeGtk

main = runRaw (400,400) $ zoom 4 $ circle purple $ zoom 0.5 $ gradientLinear blue $ gradientRadial green $ canvas white

> main = fakeGtk (1280,800) $ zoom 4 $ circle purple $ zoom 0.5 $ canvas white
