---
title: The Init File
---
### The Init File

When Atom finishes loading, it will evaluate `init.coffee` in your <span class="platform-mac platform-linux">`~/.atom`</span><span class="platform-windows">`%USERPROFILE%\.atom`</span> directory, giving you a chance to run CoffeeScript code to make customizations. Code in this file has full access to [Atom's API](https://atom.io/docs/api/latest). If customizations become extensive, consider creating a package, which we will cover in [Package: Word Count](../package-word-count).

You can open the `init.coffee` file in an editor from the <span class="platform-mac">_Atom > Init Script_</span><span class="platform-windows">_File > Init Script_</span><span class="platform-linux">_Edit > Init Script_</span> menu. This file can also be named `init.js` and contain JavaScript code.

For example, if you have the Audio Beep configuration setting enabled, you could add the following code to your `init.coffee` file to have Atom greet you with an audio beep every time it loads:

```coffee
atom.beep()
```

Because `init.coffee` provides access to Atom's API, you can use it to implement useful commands without creating a new package or extending an existing one. Here's a command which uses the [Selection API](https://atom.io/docs/api/latest/Selection) and [Clipboard API](https://atom.io/docs/api/latest/Clipboard) to construct a Markdown link from the selected text and the clipboard contents as the URL:

```coffee
atom.commands.add 'atom-text-editor', 'markdown:paste-as-link', ->
  return unless editor = atom.workspace.getActiveTextEditor()

  selection = editor.getLastSelection()
  clipboardText = atom.clipboard.read()

  selection.insertText("[#{selection.getText()}](#{clipboardText})")
```

Now, reload Atom and use the [Command Palette](/getting-started/sections/atom-basics/#command-palette) to execute the new command, "Markdown: Paste As Link", by name. And if you'd like to trigger the command via a keyboard shortcut, you can define a [keybinding for the command](/using-atom/sections/basic-customization/#customizing-keybindings).
