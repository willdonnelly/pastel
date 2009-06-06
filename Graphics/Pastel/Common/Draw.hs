module Graphics.Pastel.Common.Draw
   ( colorField, intField
   , rawBuffer
   , evenInterval
   , palettize
   ) where

import Graphics.Pastel.Common.Types

import Data.List
import qualified Data.Map as Map
import Data.Bits

import Foreign ( pokeByteOff, plusPtr )
import Data.ByteString.Internal ( unsafeCreate )
import Control.Monad ( foldM )

colorField :: (Int, Int) -> Drawing -> [[Color]]
colorField (width, height) drawing = map line tallIdx
    where line x = map drawing $ zip wideIdx $ repeat x
          wideIdx = evenInterval width
          tallIdx = evenInterval height

intField :: (Int, Int) -> Drawing -> [[Int]]
intField (w,h) d = map (map colorToInt) $ colorField (w,h) d

colorToInt :: Color -> Int
colorToInt (RGB r g b) = r' .|. g' .|. b'
    where r' = fromIntegral $ r `shiftL` 16
          g' = fromIntegral $ g `shiftL` 8
          b' = fromIntegral $ b

evenInterval :: Int -> [Float]
evenInterval n = map (scale . shift) $ take n [0..]
    where shift x = x - (n `div` 2)
          scale x = (fromIntegral (x * 2)) / (fromIntegral n)

palettize :: [[Int]] -> ([[Int]], [(Int, Int)], Int)
palettize image = (breakUp out, table, num)
    where (out, table, num) = paletteConvert $ concat image
          width = length $ head image
          breakUp = takeWhile (not . null) . unfoldr (Just . splitAt width)

paletteConvert :: [Int] -> ([Int], [(Int, Int)], Int)
paletteConvert xs = output $ foldl paletteFold ([], Map.empty, 0) xs

paletteFold :: ([Int], Map.Map Int Int, Int) -> Int -> ([Int], Map.Map Int Int, Int)
paletteFold (output, table, number) value =
    case value `Map.lookup` table of
         Nothing -> (number:output, Map.insert value number table, succ number)
         Just ix -> (ix:output, table, number)

output :: ([Int], Map.Map Int Int, Int) -> ([Int], [(Int, Int)], Int)
output (output, table, number) = (reverse output, reversePairs $ Map.assocs table, number)
    where reversePairs = map (\(x,y) -> (y,x))

rawBuffer (width, height) image = unsafeCreate (width * height * 3) draw
    where points = [ (x,y) | y<-evenInterval height, x<-evenInterval width ]
          draw ptr = do foldM (\p -> write p . image) ptr points
                        return () -- << This is a lame requirement.
          write ptr (RGB r g b) = do pokeByteOff ptr 0 r
                                     pokeByteOff ptr 1 g
                                     pokeByteOff ptr 2 b
                                     return $ plusPtr ptr 3
