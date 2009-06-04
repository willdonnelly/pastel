> module Graphics.Pastel.Draw.Raw ( rawOutput ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Utils

> import qualified Data.ByteString as BS
> import qualified Data.ByteString.Internal as BSI

> import Foreign
> import Data.Word
> import System.IO.Unsafe
> import Control.Monad

 rawOutput :: (Int, Int) -> Drawing -> BS.ByteString
 rawOutput (width,height) drawing = BS.pack $ concat $ bytes
     where bytes = [ cList . drawing $ (x,y)
                   | y <- evenInterval height
                   , x <- evenInterval width ]
           cList (RGB r g b) = [r, g, b]

> rawOutput (width, height) drawing = unsafePerformIO $ BSI.create bufferSize draw
>     where bufferSize = width * height * 3
>           draw ptr = do foldM (drawColor drawing) ptr [ (x,y) | y <- yList, x <- xList ]
>                         return ()
>               where xList = evenInterval width
>                     yList = evenInterval height

> drawColor :: Drawing -> Ptr Word8 -> (Float, Float) -> IO (Ptr Word8)
> drawColor drawing ptr = pokeColor ptr . drawing

> pokeColor :: Ptr Word8 -> Color -> IO (Ptr Word8)
> pokeColor ptr (RGB r g b) = return ptr >>= pokeInc r >>= pokeInc g >>= pokeInc b
>   where pokeInc word ptr = do
>             poke ptr word
>             return $ plusPtr ptr 1
