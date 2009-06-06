module Graphics.Pastel.Runners.XPM ( runXPM ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.XPM

runXPM (w,h) d = putStr $ drawPixmap (w,h) d
