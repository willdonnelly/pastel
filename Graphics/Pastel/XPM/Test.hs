module Graphics.Pastel.XPM.Test ( testXPM ) where

import Graphics.Pastel
import Graphics.Pastel.XPM.Draw

testXPM :: (Int, Int) -> Drawing -> IO ()
testXPM (w,h) d = putStr $ drawXPM (w,h) d
