> module Main where

> import Graphics.Pastel
> import Graphics.Pastel.Runners.Gtk
> import Graphics.Pastel.Runners.XPM

> main = runXPM (200,200) $ polygon purple [(-1,-1), (1,-1), (-1,1)] $ gradientLinear blue $ gradientRadial green $ canvas white
