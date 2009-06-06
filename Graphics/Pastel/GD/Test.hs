module Graphics.Pastel.GD.Test ( testGD ) where

import Graphics.Pastel
import Graphics.Pastel.GD.Draw
import Graphics.GD

import qualified Data.ByteString as BS

testGD :: (Int, Int) -> Drawing -> IO ()
testGD (w,h) d = do image <- drawGD (w,h) d
                    bs <- savePngByteString image
                    BS.putStrLn bs
