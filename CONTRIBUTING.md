# Contributing to the Atom Flight Manual

Contributing is easy!

1. [Fork this repository](https://github.com/atom/flight-manual.atom.io#fork-destination-box).
2. Download your fork. Refer to [the GitHub Help site](https://help.github.com/articles/fork-a-repo/#keep-your-fork-synced) if you need more information.
3. Create a named feature branch. We use the standard [GitHub Flow process](https://guides.github.com/introduction/flow/index.html).
4. Make a change to the content.
5. Push it to a branch.
6. Send us a [Pull Request](https://github.com/atom/flight-manual.atom.io/pulls).

If you're not sure about the change or the idea for the change, open an issue first to see if it's something we'll want to pull in. If you want to make some sort of sweeping grammatical or narrative change, please check with us first because we don't want you to do a ton of work and not get it merged.

## What to help with

Take a look at the [Issues List](https://github.com/atom/flight-manual.atom.io/issues) for things that people would like added or fixed.

## Adding, Removing or Reordering Pages

In order to add or remove pages, or change the ordering of pages within the Table of Contents, you should edit the [`data/toc.yml`](data/toc.yml) file.

## Conventions

In order to make the Flight Manual consistent, these conventions must be followed when adding or updating content.

### Admonition Blocks

[Admonition blocks](https://github.com/gjtorikian/extended-markdown-filter#admonition-blocks) are used to call out certain pieces of information. There are four levels of admonitions: tip, info, warning and danger.

* `tip` should be used when there is a best practice or convention that should be noted
* `note` should be used when there is some extra bit of information that is interesting, but not necessary
* `warning` should be used when there is a risk to some activity so extra caution is advised
* `danger` should be used when there is a risk of data loss or some irreversible action that needs to be taken

**Accessibility:** Always add the text version of the name of the admonition block to the first line of the first paragraph inside the block. In addition, for `danger` admonition blocks, you should add the `:rotating_light:` emoji at the very beginning. This allows people who are colorblind to tell the difference between the various blocks.

```markdown
{{#tip}}

**Tip:** This is a tip.

{{/tip}}

{{#note}}

**Note:** This is some information.

{{/note}}

{{#warning}}

**Warning:** This is some scary stuff.

{{/warning}}

{{#danger}}

:rotating_light: **Danger:** Turn back now!

{{/danger}}
```

**Note:** The block tags must be separated both above and below by blank lines:

```markdown
<!-- This works -->

{{#tip}}

**Tip:** Some interesting stuff ...

{{/tip}}

<!-- This doesn't -->

{{#tip}}
**Tip:** Some stuff that won't show up right ...
{{/tip}}
```

### OS-specific Sections

The Flight Manual now supports OS-specific content. There are three major ways to describe OS-specific content:

* OS-specific blocks
* OS-specific spans
* OS-specific keybindings - [See Keybindings below](#keybindings)

The OS-specific signifiers are:

* `platform-all` for things that apply to all platforms
* `platform-linux` for things that apply to Linux
* `platform-mac` for things that apply to Mac
* `platform-windows` for things that apply to Windows

They are listed as CSS classes in tags that delineate OS-specific stuff. For example:

```markdown
<span class="platform-mac">This text will only be seen by Mac users.</span><span class="platform-windows platform-linux">This text will be seen by both Windows and Linux users.</span>
```

`platform-all` has a special quality besides being visible to all platforms, if a page contains non-OS-specific sections or non-OS-specific sections and `platform-all` sections, the Platform Selector (see below) is not shown.

![Platform Selector](/content/getting-started/images/platform-selector.png "Platform Selector")

#### OS-specific Blocks

These use the same format as [Admonition blocks](#admonition-blocks), but apply to one of the three major platforms:

* `mac` - Content to be displayed only for macOS
* `windows` - Content to be displayed only for Windows
* `linux` - Content to be displayed only for Linux

### Language

* **DO NOT** use "hit" or "strike" when referring to activating a key combination
* **DO** use "press" or "type" when referring to activating a key combination
* **DO NOT** use Latin contractions such as "i.e.", "e.g.", "c.f.", among others
* **DO** use the English equivalent: "i.e." &rarr; "in other words", "e.g." &rarr; "for example", "c.f." &rarr; hyperlink to the thing you're referring to
* **DO** use [title-case](http://titlecase.com) for *all* headings

### Images

* **DO** use PNG for static images
* **DO** use GIF for animated images
* **AVOID** having platform-specific UI in screenshots
* If you must have platform-specific UI, create three screenshots one for each platform and use OS-specific blocks to display the correct one for the platform

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

Key combinations should be wrapped in `<kbd>` tags and presented in a common way:

1. **All** key combinations must be given *at least one* class indicating platforms to which they apply:
    * `.platform-mac` - A macOS key combination
    * `.platform-windows` - A key combination that applies to Windows
    * `.platform-linux` - A key combination that applies to Linux
    * `.platform-all` - A key combination that applies to all platforms
1. Key combinations should be wrapped in a single set of `<kbd>` tags: <kbd class="platform-mac">Cmd+N</kbd>
1. Each key combination of a key sequence should be wrapped in separate `<kbd>` tags and separated by a space: <kbd class="platform-windows platform-linux">Ctrl+K</kbd> <kbd class="platform-windows platform-linux">Right</kbd>
1. Modifier key names should be capitalized: <kbd class="platform-all">Shift</kbd>, <kbd class="platform-all">Ctrl</kbd>, <kbd class="platform-all">Alt</kbd>, <kbd class="platform-mac">Cmd</kbd>
1. Key combinations should be joined by `+`: <kbd class="platform-all">Ctrl+N</kbd>
1. Letter keys should always be capitalized: <kbd class="platform-all">N</kbd>
1. When multiple modifiers are used in a key combination, they should be presented in alphabetical order: <kbd class="platform-mac">Alt+Cmd+Ctrl+Shift+Z</kbd>

#### Terminology

* **key combination** - A key or keys intended to be pressed simultaneously, ex: <kbd>Cmd+Shift+P</kbd>
* **key sequence** - Multiple key combinations that are intended to be pressed and released in sequence, ex: <kbd>Ctrl+K</kbd> <kbd>Right</kbd>
* **keybinding** - refers to a mapping of a key combination or sequence to an Atom command
* **keymap** - refers to a collection of keybindings

### File Names and Paths

File names and paths should always be wrapped in backticks: `foo/bar/baz.txt`

### Menu Names

Menu names should always be presented in italics and each level should be separated by a single greater-than sign, `>`: *File > New*

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

Individual words or items that refer to bits of code, such as variable, API class or function names, should be surrounded by backticks. For example: `TextEditor`, `Config.set()`, `someText`

Blocks of source code should always be wrapped in [code fences](https://help.github.com/articles/creating-and-highlighting-code-blocks/#fenced-code-blocks) and annotated with the correct language to display the code syntax-highlighted.

For things that are intended to be step-by-step command-line instructions, use the [special `command-line` annotation](https://github.com/gjtorikian/extended-markdown-filter#command-line-highlighting). (Note: the space between the backticks and `command-line` is *required*.) Use this *instead* of using the `shell` annotation on a fenced-code block.
