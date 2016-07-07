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

## Best Practices

### Images

If you add images, please run `./scripts/crush.rb` (you'll also need to have the [pngcrush utility][pngcrush] installed) before committing images to the repository, and try to make them PNG files. This looks through all the files and resizes and crushes them to a book-appropriate resolution so the ebook downloads aren't stupid big.

[pngcrush]: http://pmt.sourceforge.net/pngcrush/

### Keybindings

Keybindings should be wrapped in `<kbd>` tags and presented in a common way:

1. Modifier key names should be capitalized: <kbd>Shift</kbd>, <kbd>Ctrl</kbd>, <kbd>Alt</kbd>, <kbd>Cmd</kbd>
1. Key combinations should be joined by `+`: <kbd>Ctrl+N</kbd>
1. Letter keys should always be capitalized: <kbd>N</kbd>

### File Names and Paths

File names and paths should always be wrapped in backticks: `foo/bar/baz.txt`

### Menu Names

Menu names should always be presented in italics and separated by the greater-than sign, `>`: *File > New*

### Package and Theme Names

Package and theme names, both core and community, should be presented all lowercase and hyphen-separated. When they are linked:

* Community packages and themes should be linked to their https://atom.io page: [minimap](https://atom.io/packages/minimap), [monokai](https://atom.io/themes/monokai)
* Core packages and themes should be linked to their GitHub repository: [settings-view](https://github.com/atom/settings-view)

Note: Do not add `atom/` to the beginning of the names of Core packages. We don't want to differentiate between Core and Community packages like that.
