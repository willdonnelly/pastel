module Graphics.Pastel.Draw.GD ( gdOutput ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.Utils

import Graphics.GD

import Control.Monad (foldM)
import System.IO.Unsafe (unsafePerformIO)

gdOutput (w,h) d = unsafePerformIO imageIO
  where imageIO = do image <- newImage (w,h)
                     foldM drawPixel image points
        points = [ ((a,b),(x,y))
                 | (b,y) <- zip [0..(succ h)] $ evenInterval h
                 , (a,x) <- zip [0..(succ w)] $ evenInterval w ]
        drawPixel img ((a,b),(x,y)) = do
            setPixel (a,b) (gdColor $ d (x,y)) img
            return img
        gdColor (RGB r g b) = rgb (fromIntegral r)
                                  (fromIntegral g)
                                  (fromIntegral b)
