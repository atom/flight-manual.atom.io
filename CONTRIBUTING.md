# Contributing to the Atom Flight Manual

Contributing is easy. Download this repository, make a change to the Asciidoc (or whatever you want to change), fork this repository, push it to a branch and send us a Pull Request.

If you're not sure about the change or the idea for the change, open an issue first to see if it's something we'll want to pull in. If you want to make some sort of sweeping grammatical or narrative change, please check with us first because we don't want you to do a ton of work and not get it merged.

## What to help with

You'll probably want to check the `outline.txt` file to get an idea of what we're looking for, but any help is appreciated.

Right now one of the best things you could do is to add a cookbook style tutorial into Chapter 3, showing how to create a specific type of plugin or documenting a valid use case for an otherwise uncovered Atom API.

## Images

If you add images, please run `./scripts/crush.rb` before committing images to the repository, and try to make them PNG files. This looks through all the files and resizes and crushes them to a book-appropriate resolution so the ebook downloads aren't stupid big.
