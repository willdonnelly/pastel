> module Graphics.Pastel.Runners.Gtk (runGtk) where

> import Graphics.UI.Gtk
> import Graphics.UI.Gtk.Gdk.Events

> import Graphics.Pastel
> import Graphics.Pastel.Draw.Gtk

> runGtk :: (Int, Int) -> Drawing -> IO ()
> runGtk (w,h) d = do
>     initGUI
>
>     window <- windowNew
>     set window [windowTitle := "Pastel Gtk Runner"]
>
>     pixbuf <- drawGtkPixbufXPM (w,h) $ d
>     image <- imageNewFromPixbuf pixbuf
>     containerAdd window image
>
>     widgetShowAll window
>
>     onDestroy window mainQuit
>     mainGUI
