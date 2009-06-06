module Graphics.Pastel.GTK.Draw ( drawGTK ) where

import Graphics.Pastel
import Graphics.UI.Gtk

import Foreign
import Data.Word
import Data.Bits
import qualified Data.ByteString as BS
import qualified Data.ByteString.Internal as BS

-- We generate the image data in memory, turn it into a pixbuf
-- using the `pixbufNewFromInline` function. Since the function
-- is hard-coded not to copy the inline image data, we manually
-- copy it before returning.
drawGTK :: (Int, Int) -> Drawing -> IO Pixbuf
drawGTK (w,h) d = do
    pixbuf <- withForeignPtr (castForeignPtr ptr) pixbufNewFromInline
    pixbufCopy pixbuf
  where (ptr,_,_) = BS.toForeignPtr $ gdkPixdata (w,h) d

-- Here is where we assemble the image data in memory. Some
-- decent documentation of the structure we're assembling
-- can be found at <http://library.gnome.org/devel/gdk-pixbuf/
--                  unstable/gdk-pixbuf-inline.html#GdkPixdata>
gdkPixdata :: (Int, Int) -> Drawing -> BS.ByteString
gdkPixdata (w,h) d = BS.append header image
  where image   = rawBuffer (w,h) d
        magic   = unpack32 0x47646b50 -- Hex for 'GdkP'
        length  = unpack32 $ fromIntegral $ 24 + (BS.length image)
        pxdType = unpack32 0x01010001 -- RGB, 8bpp, Raw encoding
        rStride = unpack32 $ fromIntegral $ w * 3
        width   = unpack32 $ fromIntegral $ w
        height  = unpack32 $ fromIntegral $ h
        header  = BS.pack $ concat [ magic, length, pxdType
                                   , rStride, width, height ]

-- This looks like a horrendously complicated way to convert a
-- Word32 into a [Word8]. It's not. Don't bother optimizing it
unpack32 :: Word32 -> [Word8]
unpack32 x = [ fromIntegral $ (x' .&. 0xFF000000) `shiftR` 24
             , fromIntegral $ (x' .&. 0x00FF0000) `shiftR` 16
             , fromIntegral $ (x' .&. 0x0000FF00) `shiftR` 8
             , fromIntegral $ (x' .&. 0x000000FF) `shiftR` 0 ]
  where x' = fromIntegral x :: Word32
