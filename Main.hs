module Main where

import Graphics.Pastel
import Graphics.Pastel.Runners.GD

main = runGD (1280,800) $ zoom 4 $ circle purple $ zoom 0.5 $ canvas white
