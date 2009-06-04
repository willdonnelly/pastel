> module Graphics.Pastel.Runners.FakeGtk (fakeGtk) where

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Gtk

> import qualified Data.ByteString as BS

> fakeGtk :: (Int, Int) -> Drawing -> IO ()
> fakeGtk (w,h) d = BS.putStr $ gtkPixdataRaw (w,h) d
