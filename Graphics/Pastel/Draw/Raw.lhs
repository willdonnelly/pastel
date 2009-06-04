> module Graphics.Pastel.Draw.Raw ( rawOutput ) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Utils

> import Data.ByteString.Internal ( unsafeCreate )
> import Foreign ( pokeByteOff, plusPtr )
> import Control.Monad ( foldM )

This function is crazy, having gone through several cycles of optimizing.
Basically, this function:
  1. Creates a list of all required points from the image, in order
  2. Allocates a buffer of the right size, and calls `draw` with the pointer
  3. The draw function does a fold over the points, with a function that
       writes out the current color and returns the incremented pointer.

The lambda function here is a little confusing. Just remember that folding
functions have *two* arguments. We just catch the first one in the lambda
so we can pass it to 'write'. The other (the coordinate) gets passed to
the image, and the returned color is then passed to write.

> rawOutput (width, height) image = unsafeCreate (width * height * 3) draw
>     where points = [ (x,y) | y<-evenInterval height, x<-evenInterval width ]
>           draw ptr = do foldM (\p -> write p . image) ptr points
>                         return () -- << This is a lame requirement.
>           write ptr (RGB r g b) = do pokeByteOff ptr 0 r
>                                      pokeByteOff ptr 1 g
>                                      pokeByteOff ptr 2 b
>                                      return $ plusPtr ptr 3
