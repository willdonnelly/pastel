module Graphics.Pastel.GTK.Test ( testGTK ) where

import Graphics.UI.Gtk
import Graphics.UI.Gtk.Gdk.Events

import Graphics.Pastel
import Graphics.Pastel.GTK.Draw

testGTK :: (Int, Int) -> Drawing -> IO ()
testGTK (w,h) d = do
    initGUI
    
    window <- windowNew
    set window [windowTitle := "Pastel Gtk Runner"]
    
    pixbuf <- drawGTK (w,h) $ d
    image <- imageNewFromPixbuf pixbuf
    containerAdd window image
    
    widgetShowAll window
    
    onDestroy window mainQuit
    mainGUI
