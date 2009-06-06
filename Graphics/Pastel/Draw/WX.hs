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
                       WX.pixelBufferSetPixels buffer pixels
                       WX.imageCreateFromPixelBuffer buffer
          pixels = [ wxColor . d $ (x,y) | y <- evenInterval h
                                         , x <- evenInterval w ]
          wxColor (RGB r g b) = WX.rgb (fromIntegral r) (fromIntegral g) (fromIntegral b)
