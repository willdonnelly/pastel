> module Types
>     ( Drawing
>     , Shape
>     , Point (..)
>     , Color (..)
>     , asRGB
>     ) where

A drawing is a complete image. It is represented as a function
from a coordinate to a point.

> type Drawing = (Float, Float) -> Point

A shape, on the other hand, is a function from a drawing to a
drawing. This allows easy function composition and layering,
unlike a naive representation, which would require some sort
of helper function.

> type Shape = Drawing -> Drawing

A point in the image consists of a transparency value and a
color value. The use of the word 'color' here is somewhat
inaccurate, as it includes both color and grayscale values.

> data Point = Point Alpha Color deriving (Show, Eq, Ord)

> type Alpha = Float

> data Color = RGB Float Float Float
>            | BnW Float
>            deriving (Show, Eq, Ord)

> asRGB :: Color -> Color
> asRGB (BnW v) = RGB v v v
> asRGB (RGB r g b) = RGB r g b
