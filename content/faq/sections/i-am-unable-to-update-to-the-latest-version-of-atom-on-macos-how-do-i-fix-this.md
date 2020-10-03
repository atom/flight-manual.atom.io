---
title: I am unable to update to the latest version of Atom on macOS. How do I fix this?
---
### I am unable to update to the latest version of Atom on macOS. How do I fix this?

Atom shows there is a new version available but the version fails to install. You might have an error message showing a permissions error for example:

![Updating Atom on macOS](../../images/update-atom-macos.jpeg)

or it will say downloading but forever loops without restarting or updating.

You need to fix one or more of the following directories:

* `/Applications/Atom.app/`
* `~/Library/Caches/com.github.atom.ShipIt`
* `~/Library/Application Support/com.github.atom.ShipIt`

Do the following:

1. Completely exit Atom
1. Open a terminal
1. Execute: `whoami`
1. Write down the result of the above command, this is your user name

And then execute these steps for each directory listed above in order:

1. Execute: `stat -f "%Su" [directory]`
1. It should output either your username or `root`
1. If it says `root` then execute: `sudo chown -R $(whoami) [directory]`

Once you've done the above for both directories, start Atom normally and attempt to update :+1:
