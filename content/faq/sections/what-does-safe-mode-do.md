---
title: What does Safe Mode do?
---
### What does Safe Mode do?

Atom's Safe Mode, which can be activated by completely exiting all instances of Atom and launching it again using the command `atom --safe` from the command line, does the following:

1. Does **not** load any packages from `~/.atom/packages` or `~/.atom/dev/packages`
1. Does **not** run your `init.coffee`
1. Loads only default-installed themes

The intent of Safe Mode is to determine if a problem is being caused by a community package or is caused by built-in functionality of Atom. Disabling the init script was added because people tend to use the init script as a mini-package of sorts by adding code, commands and other functionality that would normally be in a package.

For more information on Safe Mode, check the [debugging section](http://flight-manual.atom.io/hacking-atom/sections/debugging/).
