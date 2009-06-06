module Graphics.Pastel.Common.Types
    ( Drawing, Shape, Color (..), colorAdd, colorScale
    ) where

import Data.Word

-- A drawing is a complete image. It is represented as a function
-- from a coordinate to a color value.

type Drawing = (Float, Float) -> Color

-- A primitive is a function from a drawing to a drawing. This makes
-- composing primitives into images incredibly easy.

type Shape = Drawing -> Drawing

-- The use of the word 'color' here is a little bit inaccurate, as
-- this datatype encompasses both color and grayscale values.

data Color = RGB Word8 Word8 Word8 deriving (Show, Eq, Ord)

(RGB a b c) `colorAdd` (RGB x y z) = RGB (a+x) (b+y) (c+z)
(RGB a b c) `colorScale` s = RGB (scale a) (scale b) (scale c)
    where scale x = truncate $ (fromIntegral x) * s
