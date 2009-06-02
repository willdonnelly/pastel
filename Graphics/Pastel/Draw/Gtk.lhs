> module Graphics.Pastel.Draw.Gtk
>     ( drawGtkPixbufRaw
>     , drawGtkPixbufXPM
>     ) where

> import Graphics.Pastel.Types
> import Graphics.Pastel.Draw.XPM

> import Graphics.UI.Gtk

This method generates the image data in memory, and then
turns it into a pixbuf using the `pixbufNewFromInline`
function. Since the function is hard-coded not to copy
the inline image data, we manually copy it next. The
docs say that `pixbufCopy` performs a 'deep copy', so
I interpret this to mean it copies the underlying data.

> drawGtkPixbufRaw :: (Int, Int) -> Drawing -> IO Pixbuf
> drawGtkPixbufRaw = undefined

The XPM functionality is pretty straightforward given the
existence of an XPM output function. The only irregularity
is that the XPM function generates XPM2, which has a header
line saying "! XPM2" and consists of a single string with
newlines, and GTK wants XPM3, which lacks the header and
has each line in a separate string in an array.

> drawGtkPixbufXPM :: (Int, Int) -> Drawing -> IO Pixbuf
> drawGtkPixbufXPM (w,h) d = pixbufNewFromXPMData xpmData
>     where xpmData = tail $ lines $ drawPixmap (w,h) d
