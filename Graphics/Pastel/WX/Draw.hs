module Graphics.Pastel.WX.Draw ( drawWX ) where

import Graphics.UI.WXCore.Types ( sz )
import Graphics.UI.WXCore.WxcClassTypes ( Image )
import Graphics.UI.WXCore.WxcClassesAL ( imageCreateFromData )

import Graphics.Pastel (Drawing, rawBuffer)

import Data.ByteString.Internal (toForeignPtr)
import Foreign (withForeignPtr)

drawWX :: (Int, Int) -> Drawing -> IO (Image ())
drawWX (w,h) d = withForeignPtr ptr $ imageCreateFromData (sz w h)
    where (ptr,_,_) = toForeignPtr $ rawBuffer (w,h) d
