module Graphics.Pastel.Runners.Raw ( runRaw ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.Raw

import qualified Data.ByteString as BS

runRaw :: (Int, Int) -> Drawing -> IO ()
runRaw (w,h) d = BS.putStrLn $ rawOutput (w,h) d
