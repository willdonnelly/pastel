module Graphics.Pastel.Runners.GD ( runGD ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.GD

import Graphics.GD

import qualified Data.ByteString as BS

runGD (w,h) d = do image <- gdOutput (w,h) d
                   bs <- savePngByteString image
                   BS.putStrLn bs
