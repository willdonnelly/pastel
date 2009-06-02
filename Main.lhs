> module Main where

> import Graphics.Pastel
> import Graphics.Pastel.Runners.Gtk
> import Graphics.Pastel.Runners.XPM

> main = runXPM (128,128) $ polygon purple [(-1,-1), (1,-1), (-1,1)] $ gradient green $ canvas white
