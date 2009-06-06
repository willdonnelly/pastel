module Graphics.Pastel.Runners.GD ( runGD ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.GD

import Graphics.GD

import qualified Data.ByteString as BS

runGD (w,h) d = do bs <- savePngByteString $ gdOutput (w,h) d
                   BS.putStrLn bs