module Main where

import Graphics.Pastel

import Graphics.Pastel.GD
import Graphics.Pastel.GTK
import Graphics.Pastel.WX
import Graphics.Pastel.XPM

main = testWX (1280,800) $ zoom 4 $ circle purple $ zoom 0.5 $ canvas white
