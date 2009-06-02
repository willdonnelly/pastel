> module Graphics.Pastel.Types
>     ( Drawing, Shape, Color (..)
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
