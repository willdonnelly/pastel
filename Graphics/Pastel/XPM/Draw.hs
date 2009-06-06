module Graphics.Pastel.XPM.Draw ( drawXPM ) where

import Graphics.Pastel

import Numeric
import Data.Maybe
import Data.List
import Data.Array

hexOut :: Int -> Int -> String
hexOut l x = (replicate padLen '0') ++ hex
    where padLen = l - length hex
          hex = showHex x ""

drawXPM :: (Int, Int) -> Drawing -> String
drawXPM (width, height) drawing = unlines $ concat [[magic], [header], palette, image]
    where magic = "! XPM2"
          header = unwords $ map show [width, height, pSize, indexSize]
          palette = map paletteLine pLookup
              where paletteLine (i,c) = hexOut indexSize i ++ " c #" ++ hexOut 6 c
          image = map imageLine pImage
              where imageLine xs = concat $ map (hexOut indexSize) xs
          indexSize = ceiling $ log (succ $ fromIntegral pSize) / (4 * log 2)
          (pImage, pLookup, pSize) = palettize $ intField (width, height) drawing

splitLength x = takeWhile (not . null) . unfoldr (Just . splitAt x)
