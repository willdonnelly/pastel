> module Graphics.Pastel.Types
>     ( Drawing, Shape, Color (..), colorAdd, colorScale
>     ) where

A drawing is a complete image. It is represented as a function
from a coordinate to a color value.

> type Drawing = (Float, Float) -> Color

A primitive is a function from a drawing to a drawing. This makes
composing primitives into images incredibly easy.

> type Shape = Drawing -> Drawing

The use of the word 'color' here is a little bit inaccurate, as
this datatype encompasses both color and grayscale values.

> data Color = RGB Float Float Float deriving (Show, Eq, Ord)

> (RGB a b c) `colorAdd` (RGB x y z) = RGB (hold (a+x)) (hold (b+y)) (hold (c+z))
> (RGB a b c) `colorScale` s = RGB (hold (a*s)) (hold (b*s)) (hold (c*s))
> hold x = min (max x 0) 1
