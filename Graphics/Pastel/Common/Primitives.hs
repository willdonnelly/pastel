module Graphics.Pastel.Common.Primitives
    ( circle, square, polygon
    , rotate, translate
    , zoom, scale
    , gradientLinear, gradientRadial
    , tint, canvas
    ) where

import Graphics.Pastel.Common.Types
import Graphics.Pastel.Common.Colors

circle :: Color -> Drawing -> Drawing
circle c f (x,y) = if x*x + y*y < 1.0 then c else f (x,y)

square :: Color -> Drawing -> Drawing
square c f (x,y) = if (abs x) < 1.0 && (abs y) < 1.0 then c else f (x,y)

-- To determine whether a point is in a polygon, we sum the angles between the
-- point and all vertices of the polygon. If it equals 2*pi, we're good.
-- Unfortunately, floating point roundoff screws that a little, so we actually
-- test whether the angle is within an arbitrarily chosen distance of 2*pi.
-- The current value 0.0001 is just arbitrarily chosen, it could need revisiting
-- at a later date.

polygon :: Color -> [(Float, Float)] -> Drawing -> Drawing
polygon c vs f (x,y) = if testValue < 0.0001 then c else f (x,y)
          -- Calculate the difference between this number and 2*pi
    where testValue = abs $ (2*pi-) $ sumAngles (x,y) vs
          -- Sum the angles between the test point and all consecutive vertex pairs
          sumAngles (x,y) vs = sum $ zipWith (angle (x,y)) vs (tail $ cycle vs)
          -- Calculate the angle between three points
          angle (x,y) (a,b) (c,d)
              | dTheta < (-pi)  =  dTheta + 2*pi
              | dTheta >   pi   =  dTheta - 2*pi
              | otherwise       =  dTheta 
              where dTheta = theta2 - theta1
                    theta1 = atan2 (b-y) (a-x)
                    theta2 = atan2 (d-y) (c-x)

rotate :: Float -> Drawing -> Drawing
rotate t f (x,y) = f (x*c - y*s, x*s + y*c)
    where (c,s) = (cos t, sin t)

translate :: (Float, Float) -> Drawing -> Drawing
translate (a,b) f (x,y) = f (x-a, y-b)

zoom :: Float -> Drawing -> Drawing
zoom s f (x,y) = f (x*s, y*s)

scale :: (Float, Float) -> Drawing -> Drawing
scale (a,b) f (x,y) = f (x/a, y/b)

-- Tint is a useful function. It will replace every instance of
-- the first color with the second, and pass everything else untouched.

tint :: Color -> Color -> Drawing -> Drawing
tint a b f (x,y) = let v = f (x,y) in if v == a then b else v

gradientLinear :: Color -> Drawing -> Drawing
gradientLinear c f (x,y) = (c `colorScale` p) `colorAdd` (f (x,y) `colorScale` q)
    where p = (x + 1) / 2
          q = 1 - p

gradientRadial :: Color -> Drawing -> Drawing
gradientRadial c f (x,y) = (c `colorScale` p) `colorAdd` (f (x,y) `colorScale` q)
    where p = (x*x + y*y) / 2
          q = 1 - p

-- The canvas function is what actually allows us to draw stuff.
-- It just creates an endless field of a given color. All other
-- primitives should be made to draw on top of a canvas, for
-- maximum flexibility.

canvas :: Color -> Drawing
canvas c (x,y) = c
