---
title: The menu bar disappeared, how do I get it back?
---
### The menu bar disappeared, how do I get it back?

If you're running Windows or Linux and you don't see the menu bar, it may have been accidentally toggled it off.  You can bring it back from the Command Palette with `Window: Toggle Menu Bar` or by pressing <kbd>Alt</kbd>.

You can disable hiding the menu bar with <kbd>Alt</kbd> by unchecking `Settings > Core > Auto Hide Menu Bar`.

You can also do <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the Command Palette and type `Window:Toggle Menu Bar` to toggle it back.

Another option is to navigate to `%USERPROFILE%\.atom` and open `config.cson` in a text editor. Change the field `titleBar:` to `"native"` and relaunch Atom. 
