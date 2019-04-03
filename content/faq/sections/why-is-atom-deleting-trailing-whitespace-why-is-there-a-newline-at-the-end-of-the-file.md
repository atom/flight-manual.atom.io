---
title: Why is Atom deleting trailing whitespace? Why is there a newline at the end of the file?
---
### Why is Atom deleting trailing whitespace? Why is there a newline at the end of the file?

Atom ships with the [`whitespace` package][1], which by default strips trailing whitespace from lines in your file, and inserts a final trailing newline to indicate end-of-file [as per the POSIX standard][2].

You can disable this feature by going to the Packages list in the Settings View and finding the whitespace package:

![Whitespace package settings](../../images/whitespace-settings.png "Whitespace package settings")

Take a look at [the Whitespace section][3] for more information.

[1]: https://github.com/atom/whitespace
[2]: http://stackoverflow.com/a/729795/1459498
[3]: /using-atom/sections/editing-and-deleting-text/#whitespace
