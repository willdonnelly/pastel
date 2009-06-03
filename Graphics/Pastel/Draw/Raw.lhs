> module Graphics.Pastel.Draw.Raw
>     ( rawOutput
>     ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Utils

> import qualified Data.ByteString as BS

> rawOutput :: (Int, Int) -> Drawing -> BS.ByteString
> rawOutput (w,h) d = BS.pack $ image
>     where image = foldl assembleBytes [] $ reverse colors
>           colors = concat $ colorField (w,h) d

> assembleBytes xs (RGB r g b) = r:g:b:xs
