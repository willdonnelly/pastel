module Main where

import Graphics.Pastel
import Graphics.Pastel.Runners.WX

main = runWX (1280,800) $ zoom 4 $ circle purple $ zoom 0.5 $ canvas white
