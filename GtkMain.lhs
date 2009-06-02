> module Main where

> import Graphics.UI.Gtk
> import Graphics.UI.Gtk.Gdk.Events

> import Colors
> import Types
> import Shapes
> import DrawGtk

> main :: IO ()
> main = do
>     initGUI
>
>     window <- windowNew
>     set window [windowTitle := "Hello Cairo"]
>
>     pixbuf <- drawGtkPixbufXPM (256, 256) $ circle $ canvas white
>     image <- imageNewFromPixbuf pixbuf
>     containerAdd window image
>
>     widgetShowAll window
>
>     onDestroy window mainQuit
>     mainGUI
