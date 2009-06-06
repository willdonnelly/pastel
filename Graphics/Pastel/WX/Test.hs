module Graphics.Pastel.WX.Test ( testWX ) where

import Graphics.UI.WX hiding (circle)
import Graphics.UI.WXCore.Image

import Graphics.Pastel
import Graphics.Pastel.WX.Draw

testWX :: (Int, Int) -> Drawing -> IO ()
testWX (w,h) d = start gui
    where gui = do
              window <- frame [text := "Pastel WX Runner"]
              canvas <- panel window [on paint := redraw]
              return ()
          redraw dc viewArea = do image <- drawWX (w,h) d
                                  drawImage dc image (Point 0 0) []
