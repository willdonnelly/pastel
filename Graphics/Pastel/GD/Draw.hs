module Graphics.Pastel.GD.Draw ( drawGD ) where

import Graphics.Pastel
import Graphics.GD

import Control.Monad (foldM)

drawGD (w,h) d =
    do image <- newImage (w,h)
       foldM draw image points
  where draw img (ci,cf) = setPixel ci (gdDraw cf) img >> return img
        gdDraw = withRGB rgb . d
        points = [ ((a,b),(x,y))
                 | (b,y) <- zip [0..(succ h)] $ evenInterval h
                 , (a,x) <- zip [0..(succ w)] $ evenInterval w ]
