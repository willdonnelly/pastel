GTK Drawing Procedures:

  1. Generate XPM, load that.
     * Pros
       - Guaranteed to work, basically
     * Cons
       - Slow, ugly
  2. Use inline data methods
     * pixbufNewFromInline
     * pixbufCopy
     * Pros
       - Fast, powerful
     * Cons
       - Possibly brittle and/or unsafe
     * We'll have to wait and see

Any reason I can't do both?

> module DrawGtk
>     ( drawGtkPixbufRaw
>     , drawGtkPixbufXPM
>     ) where

> import Types
> import DrawPixmap
> import Graphics.UI.Gtk

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
