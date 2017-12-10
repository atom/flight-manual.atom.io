---
title: Glossary
---
### Glossary

Below is a list of some useful terms we use with regard to Atom.

#### Buffer

A buffer is the text content of a file in Atom. It's basically the same as a file for most descriptions, but it's the version Atom has in memory. For instance, you can change the text of a buffer and it isn't written to its associated file until you save it.

#### Command

A command is a bit of functionality in Atom that can be triggered by the user either through a [keybinding](#keybinding) or a menu item.

#### Dock

Docks are collapsible [pane containers](#pane-container) that attach to the left, right, and bottom sides of the Atom window.

Examples:

* Tree View
* Git
* GitHub

#### Key Combination

A key combination is some combination or sequence of keys that are pressed to perform a task.

Examples:

* <kbd class="platform-all">A</kbd>
* <kbd class="platform-all">Ctrl+Enter</kbd>
* <kbd class="platform-all">Ctrl+K</kbd> <kbd class="platform-all">Right</kbd>

#### Key Sequence

A key sequence is a special case of a key combination. It is a key combination that consists of keys that must be pressed and released in sequence. <kbd class="platform-all">Ctrl+K</kbd> <kbd class="platform-all">Down</kbd> is a key sequence. <kbd class="platform-all">Alt+S</kbd> is not a key sequence because it is two keys that are pressed and released together rather than in succession.

#### Keybinding

A keybinding is the mapping of a [key combination](#key-combination), such as <kbd class="platform-all">Ctrl+Enter</kbd> to an Atom command.

#### Keymap

A keymap is a collection of [keybindings](#keybinding). It can also refer to a file or files containing keybindings for an Atom package or Atom itself.

#### Package

An Atom plugin. There is a bunch more information in the section on [Atom Packages](/using-atom/sections/atom-packages/).

#### Pane

A pane is a visual section of the editor space. Each pane can hold multiple [pane items](#pane-item). There is always at least one pane in each Atom window.

#### Pane Container

A section of the Atom UI that can contain multiple [panes](#pane).

#### Pane Item

Some item, often an editor, that is displayed within a [pane](#pane). In the default configuration of Atom, pane items are represented by tabs at the top of each pane.

{{#note}}

**Note:** The reason why we don't call them "tabs" is because you can disable the [tabs package](https://github.com/atom/tabs) and then there aren't any tabs. For a similar reason, we don't call them files because some things can be shown in a pane that aren't files, like the Settings View.

{{/note}}

#### Panel

A piece of the Atom UI that is outside the editor space.

Examples:

* Find and Replace
* Keybinding Resolver
