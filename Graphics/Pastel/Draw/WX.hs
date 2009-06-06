module Graphics.Pastel.Draw.WX ( drawWXImage ) where

import qualified Graphics.UI.WX as WX
import qualified Graphics.UI.WXCore.Image as WX
import qualified Graphics.UI.WXCore.WxcClassTypes as WX

import Graphics.Pastel
import Graphics.Pastel.Draw.Utils

import System.IO.Unsafe

drawWXImage :: (Int, Int) -> Drawing -> WX.Image ()
drawWXImage (w,h) d = unsafePerformIO image
    where image = WX.imageCreateFromPixels (WX.Size w h) pixels
          pixels = map (wxColor . d) points
          points = [(x,y) | y <- evenInterval h, x <- evenInterval w]

wxColor (RGB r g b) = WX.rgb (fromIntegral r) (fromIntegral g) (fromIntegral b)
