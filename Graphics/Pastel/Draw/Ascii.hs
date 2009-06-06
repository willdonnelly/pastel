module Graphics.Pastel.Draw.Ascii ( drawAscii ) where

import Graphics.Pastel
import Graphics.Pastel.Draw.Utils

import Data.List

drawAscii (width, height) drawing = unlines $ map (map ascii) $ points
    where points = colorField (width, height) drawing
          ascii c = if c == white then '.' else '#'
