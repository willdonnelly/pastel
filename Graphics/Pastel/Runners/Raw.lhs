> module Graphics.Pastel.Runners.Raw
>     ( runRaw
>     ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Raw

> import Data.Word
> import Numeric
> import qualified Data.ByteString as BS

> runRaw :: (Int, Int) -> Drawing -> IO ()
> runRaw (w,h) d = BS.putStrLn $ raw
>     where raw = rawOutput (w,h) d

> showByte :: Word8 -> String
> showByte b = if length s == 1 then '0':s else s
>     where s = showHex (fromIntegral b) ""
