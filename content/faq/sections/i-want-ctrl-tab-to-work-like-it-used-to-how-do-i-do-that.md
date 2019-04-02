---
title: I want Ctrl-Tab to work like it used to. How do I do that?
---
### I want Ctrl-Tab to work like it used to. How do I do that?

#### In Atom 1.14 or later

An option was added to the [tabs package](https://github.com/atom/tabs) in Atom 1.14 to restore the original behavior:

1. Launch Atom
1. Open the Settings View using <kbd class="platform-mac">Cmd+,</kbd><kbd class="platform-linux platform-windows">Ctrl+,</kbd>
1. Click the Packages tab
1. Search for "tabs"
1. Click the Settings button on the tabs package card
1. Uncheck "Enable MRU Tab Switching"

-----

#### In earlier versions

Add the following to your `keymap.cson`:

```coffee
'body':
  'ctrl-tab ^ctrl': 'unset!'
  'ctrl-tab': 'pane:show-next-item'
  'ctrl-shift-tab ^ctrl': 'unset!'
  'ctrl-shift-tab': 'pane:show-previous-item'
```
