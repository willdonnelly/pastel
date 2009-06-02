> module Graphics.Pastel.Runners.Gtk (runGtk) where

> import Graphics.UI.Gtk
> import Graphics.UI.Gtk.Gdk.Events

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Gtk

> runGtk :: IO ()
> runGtk = do
>     initGUI
>
>     window <- windowNew
>     set window [windowTitle := "Pastel Gtk Runner"]
>
>     pixbuf <- drawGtkPixbufXPM (1024, 1024) $ circle $ canvas white
>     image <- imageNewFromPixbuf pixbuf
>     containerAdd window image
>
>     widgetShowAll window
>
>     onDestroy window mainQuit
>     mainGUI
