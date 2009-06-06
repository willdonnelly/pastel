module Graphics.Pastel.Draw.WX ( drawWXImage ) where

import qualified Graphics.UI.WX as WX
import qualified Graphics.UI.WXCore.Image as WX
import qualified Graphics.UI.WXCore.WxcClassTypes as WX

import Graphics.Pastel
import Graphics.Pastel.Draw.Utils

import System.IO.Unsafe
import Control.Monad

drawWXImage :: (Int, Int) -> Drawing -> WX.Image ()
drawWXImage (w,h) d = unsafePerformIO imageIO
    where imageIO = do buffer <- WX.pixelBufferCreate (WX.Size w h)
                       foldM drawPoint buffer points
                       WX.imageCreateFromPixelBuffer buffer
          points = [ (x,y) | y <- zip [0..(succ h)] $ evenInterval h
                           , x <- zip [0..(succ w)] $ evenInterval w ]
          drawPoint buffer ((xi,xf),(yi,yf)) = do
              WX.pixelBufferSetPixel buffer (WX.Point xi yi) $ wxColor $ d (xf,yf)
              return buffer
          wxColor (RGB r g b) = WX.rgb (fromIntegral r) (fromIntegral g) (fromIntegral b)
