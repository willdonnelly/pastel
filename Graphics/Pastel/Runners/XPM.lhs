> module Graphics.Pastel.Runners.XPM ( runXPM ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.XPM

> runXPM = putStr $ drawPixmap (1024, 1024) $ circle $ canvas black
