module Graphics.Pastel.Runners.WX (runWX) where

import Graphics.UI.WX hiding (circle)
import Graphics.UI.WXCore.Image

import Graphics.Pastel
import Graphics.Pastel.Draw.WX

runWX :: (Int, Int) -> Drawing -> IO ()
runWX (w,h) d = start gui
    where gui = do
              window <- frame [text := "Pastel WX Runner"]
              canvas <- panel window [on paint := redraw]
              return ()
          redraw dc viewArea = let image = drawWXImage (w,h) d in
                                   drawImage dc image (Point 0 0) []
