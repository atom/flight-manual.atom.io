# Contributing to the Atom Flight Manual

Contributing is easy!

1. [Fork this repository](https://github.com/atom/flight-manual.atom.io#fork-destination-box)
2. Download your fork. [(Click here for help)](https://help.github.com/articles/fork-a-repo/#keep-your-fork-synced)
3. Create a named feature branch ([we use Github flow](https://guides.github.com/introduction/flow/index.html))
4. Make a change to the Asciidoc (or whatever you want to change),
5. push it to a branch
6. send us a [Pull Request](https://github.com/atom/flight-manual.atom.io/pulls).

If you're not sure about the change or the idea for the change, open an issue first to see if it's something we'll want to pull in. If you want to make some sort of sweeping grammatical or narrative change, please check with us first because we don't want you to do a ton of work and not get it merged.

## What to help with

You'll probably want to check the `outline.md` file to get an idea of what we're looking for, but any help is appreciated.

Right now one of the best things you could do is to add a cookbook style tutorial into Chapter 3, showing how to create a specific type of plugin or documenting a valid use case for an otherwise uncovered Atom API.

## Images

If you add images, please run `./scripts/crush.rb` (you'll also need to have the [pngcrush utility][pngcrush] installed) before committing images to the repository, and try to make them PNG files. This looks through all the files and resizes and crushes them to a book-appropriate resolution so the ebook downloads aren't stupid big.

[pngcrush]: http://pmt.sourceforge.net/pngcrush/
