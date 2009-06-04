> module Graphics.Pastel.Draw.Raw ( rawOutput ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Utils

> import qualified Data.ByteString as BS

> rawOutput :: (Int, Int) -> Drawing -> BS.ByteString
> rawOutput (width,height) drawing = BS.pack $ concat $ bytes
>     where bytes = [ cList . drawing $ (x,y)
>                   | y <- reverse . evenInterval $ height
>                   , x <- reverse . evenInterval $ width ]
>           cList (RGB r g b) = [r, g, b]
