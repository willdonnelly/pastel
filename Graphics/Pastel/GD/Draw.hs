module Graphics.Pastel.GD.Draw ( drawGD ) where

import Graphics.Pastel
import Graphics.GD
import Control.Monad (foldM)

drawGD (w,h) d = do image <- newImage (w,h)
                    foldM drawPixel image points
  where points = [ ((a,b),(x,y))
                 | (b,y) <- zip [0..(succ h)] $ evenInterval h
                 , (a,x) <- zip [0..(succ w)] $ evenInterval w ]
        drawPixel img ((a,b),(x,y)) = do
            setPixel (a,b) (gdColor $ d (x,y)) img
            return img
        gdColor (RGB r g b) = rgb (fromIntegral r)
                                  (fromIntegral g)
                                  (fromIntegral b)
