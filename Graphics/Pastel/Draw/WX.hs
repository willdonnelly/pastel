module Graphics.Pastel.Draw.WX ( drawWXImage ) where

import Graphics.UI.WXCore.Types ( sz )
import Graphics.UI.WXCore.WxcClassTypes ( Image )
import Graphics.UI.WXCore.WxcClassesAL ( imageCreateFromData )

import Graphics.Pastel (Drawing)
import Graphics.Pastel.Draw.Raw (rawOutput)

import Data.ByteString.Internal (toForeignPtr)
import Foreign (withForeignPtr)

drawWXImage :: (Int, Int) -> Drawing -> IO (Image ())
drawWXImage (w,h) d = withForeignPtr ptr $ imageCreateFromData (sz w h)
    where (ptr,_,_) = toForeignPtr $ rawOutput (w,h) d
