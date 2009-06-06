module Graphics.Pastel.GTK.Draw ( drawGTK ) where

import Graphics.Pastel

import qualified Data.ByteString as BS
import qualified Data.ByteString.Internal as BSI
import Data.Bits
import Foreign

import Graphics.UI.Gtk

-- This method generates the image data in memory, and then
-- turns it into a pixbuf using the `pixbufNewFromInline`
-- function. Since the function is hard-coded not to copy
-- the inline image data, we manually copy it next. The
-- docs say that `pixbufCopy` performs a 'deep copy', so
-- I interpret this to mean it copies the underlying data.

drawGTK :: (Int, Int) -> Drawing -> IO Pixbuf
drawGTK (w,h) d = withForeignPtr (castForeignPtr ptr) pixbufNewFromInline >>= pixbufCopy
    where rawData = gtkPixdataRaw (w, h) d
          (ptr,_,_) = BSI.toForeignPtr rawData

gtkPixdataRaw (w, h) d = BS.append header image
    where image = rawBuffer (w,h) d
          magic = unpack32 0x47646b50 -- Hex for 'GdkP'
          length = unpack32 $ fromIntegral $ 24 + (BS.length image) -- Header plus image size
          pxdType = unpack32 0x01010001 -- RGB, 8bpp, raw
          rowstride = unpack32 $ fromIntegral $ w * 3 -- The row holds 3 bytes per pixel in width
          width = unpack32 $ fromIntegral $ w
          height = unpack32 $ fromIntegral $ h
          header = BS.pack $ concat [magic, length, pxdType, rowstride, width, height]

-- This looks like a horrendously complicated way to convert a
-- Word32 into a [Word8]. It's not. The performance impact has been
-- measured at exactly zero. It optimizes into some magic, and ends
-- up being less costly than some of the *constants* in this program.

unpack32 :: Word32 -> [Word8]
unpack32 x = [ fromIntegral $ (`shiftR` 24) $ (fromIntegral x .&. 0xFF000000 :: Word32)
             , fromIntegral $ (`shiftR` 16) $ (fromIntegral x .&. 0x00FF0000 :: Word32)
             , fromIntegral $ (`shiftR`  8) $ (fromIntegral x .&. 0x0000FF00 :: Word32)
             , fromIntegral $ (`shiftR`  0) $ (fromIntegral x .&. 0x000000FF :: Word32) ]
