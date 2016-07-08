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

## Conventions

In order to make the Flight Manual consistent, these conventions must be followed when adding or updating content.

### Admonition Blocks

[Admonition blocks](https://github.com/gjtorikian/extended-markdown-filter#admonition-blocks) are used to call out certain pieces of information. There are four levels of admonitions: tip, info, warning and danger.

* `tip` should be used when there is a best practice or convention that should be noted
* `info` should be used when there is some extra bit of information that is interesting, but not necessary
* `warning` should be used when there is a risk to some activity so extra caution is advised
* `danger` should be used when there is a risk of data loss or some irreversible action that needs to be taken

### Language

* **DO NOT** use Latin contractions such as "i.e.", "e.g.", "c.f.", among others
* **DO** use the English equivalent: "i.e." &rarr; "in other words", "e.g." &rarr; "for example", "c.f." &rarr; hyperlink to the thing you're referring to

### Images

If you add images, run `./scripts/crush.rb` (you'll also need to have the [pngcrush utility][pngcrush] installed) before committing images to the repository, and try to make them PNG files. This looks through all the files and resizes and crushes them to an appropriate resolution.

Always add both a description and title text to image links:

```markdown
![First Launch](/content/getting-started/images/first-launch.png "First Launch")
```

This way when someone hovers over the image, the description of the image appears. It is also better for accessibility:

![First Launch](/content/getting-started/images/first-launch.png "First Launch")

#### Screenshots

All screenshots should be taken using Atom's default themes and settings.

[pngcrush]: http://pmt.sourceforge.net/pngcrush/

### Keybindings

Keybindings should be wrapped in `<kbd>` tags and presented in a common way:

1. Key combinations should be wrapped in a single set of `<kbd>` tags: <kbd>Cmd+N</kbd>
1. Each key combination of a key sequence should be wrapped in separate `<kbd>` tags and separated by a space: <kbd>Ctrl+K</kbd> <kbd>Right</kbd>
1. Modifier key names should be capitalized: <kbd>Shift</kbd>, <kbd>Ctrl</kbd>, <kbd>Alt</kbd>, <kbd>Cmd</kbd>
1. Key combinations should be joined by `+`: <kbd>Ctrl+N</kbd>
1. Letter keys should always be capitalized: <kbd>N</kbd>
1. When multiple modifiers are used in a key combination, they should be presented in alphabetical order: <kbd>Alt+Cmd+Ctrl+Shift+Z</kbd>

#### Terminology

* **key combination** - A key or keys intended to be pressed simultaneously, ex: <kbd>Cmd+Shift+P</kbd>
* **key sequence** - Multiple key combinations that are intended to be pressed and released in sequence, ex: <kbd>Ctrl+K</kbd> <kbd>Right</kbd>
* **keybinding** - refers to a mapping of a key combination or sequence to an Atom command
* **keymap** - refers to a collection of keybindings

### File Names and Paths

File names and paths should always be wrapped in backticks: `foo/bar/baz.txt`

### Menu Names

Menu names should always be presented in italics and separated by the greater-than sign, `>`: *File > New*

### Names of UI Elements

When referring to a part of the Atom UI, [title case](http://titlecase.com/) and don't hyphenate it, even if the name of the part of the UI is also its package name. For example: Tree View, Settings View, Status Bar, Find and Replace.

### Package and Theme Names

Package and theme names, both core and community, should be presented all lowercase and hyphen-separated.

When they are linked:

* Community packages and themes should be linked to their https://atom.io page: [minimap](https://atom.io/packages/minimap), [monokai](https://atom.io/themes/monokai)
* Core packages and themes should be linked to their GitHub repository: [settings-view](https://github.com/atom/settings-view)

Note: Do not add `atom/` to the beginning of the names of Core packages. We don't want to differentiate between Core and Community packages like that.

When they are not linked, do not italicize, bold or monospace the package or theme name.

### Code

Blocks of source code should always be wrapped in [code fences](https://help.github.com/articles/creating-and-highlighting-code-blocks/#fenced-code-blocks) and annotated with the correct language to display the code syntax-highlighted.

For things that are intended to be step-by-step command-line instructions, use the [special `command-line` annotation](https://github.com/gjtorikian/extended-markdown-filter#command-line-highlighting). (Note: the space between the backticks and `command-line` is *required*.) Use this *instead* of using the `shell` annotation on a fenced-code block.
