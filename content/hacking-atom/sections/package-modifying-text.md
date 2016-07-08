---
title: "Package: Modifying Text"
---
### Package: Modifying Text

Now that we have our first package written, let's go through examples of other types of packages we can make. This section will guide you though creating a simple command that replaces the selected text with [ascii art](https://en.wikipedia.org/wiki/ASCII_art). When you run our new command with the word "cool" selected, it will be replaced with:

```
                                     o888
    ooooooo     ooooooo     ooooooo   888
  888     888 888     888 888     888 888
  888         888     888 888     888 888
    88ooo888    88ooo88     88ooo88  o888o

```

This should demonstrate how to do basic text manipulation in the current text buffer and how to deal with selections.

The final package can be viewed at https://github.com/atom/ascii-art.

#### Basic Text Insertion

To begin, press `cmd-shift-P` to bring up the [Command Palette](https://github.com/atom/command-palette). Type "generate package" and select the "Package Generator: Generate Package" command, just as we did in [Generate Package](/hacking-atom/sections/package-word-count/#generate-package). Enter `ascii-art` as the name of the package.

Now let's edit the package files to make our ASCII Art package do something interesting. Since this package doesn't need any UI, we can remove all view-related code so go ahead and delete `lib/ascii-art-view.coffee`, `spec/ascii-art-view-spec.coffee`, and `styles/`.

Next, open up `lib/ascii-art.coffee` and remove all view code, so it looks like this:

```coffeescript
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'ascii-art:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    console.log 'Convert text!'
```

##### Create a Command

Now let's add a command. It is recommended that you namespace your commands with the package name followed by a `:`, so as you can see in the code, we called our command `ascii-art:convert` and it will call the `convert()` method when it's called.

So far, that will simply log to the console. Let's start by making it insert something into the text buffer.

```coffeescript
convert: ->
  if editor = atom.workspace.getActiveTextEditor()
    editor.insertText('Hello, World!')
```

As in [Counting Words](/hacking-atom/sections/package-word-count/counting-words), we're using `atom.workspace.getActiveTextEditor()` to get the object that represents the active text editor. If this `convert()` method is called when not focused on a text editor, this will simply return a blank string, so we can skip the next line.

Next we insert a string into the current text editor with the [`insertText()`](https://atom.io/docs/api/latest/TextEditor#instance-insertText) method. This will insert the text wherever the cursor currently is in the current editor. If there is a selection, it will replace all selections with the "Hello, World!" text.

##### Reload the Package

Before we can trigger `ascii-art:convert`, we need to load the latest code for our package by reloading the window. Run the command "Window: Reload" from the command palette or by pressing `ctrl-alt-cmd-l`.

##### Trigger the Command

Now open the command panel and search for the "Ascii Art: Convert" command. But it's not there! To fix this, open `package.json` and find the property called `activationCommands`. Activation commands speed up load time by allowing Atom to delay a package's activation until it's needed. So remove the existing command and use `ascii-art:convert` in `activationCommands`:

```json
"activationCommands": {
  "atom-workspace": "ascii-art:convert"
}
```

First, reload the window by running the command "Window: Reload" from the command palette. Now when you run the "Ascii Art: Convert" command it will output 'Hello, World!'

##### Add a Key Binding

Now let's add a key binding to trigger the `ascii-art:convert` command. Open `keymaps/ascii-art.cson` and add a key binding linking `ctrl-alt-a` to the `ascii-art:convert` command. You can delete the pre-existing key binding since you don't need it anymore.

When finished, the file should look like this:

```coffeescript
'atom-text-editor':
  'ctrl-alt-a': 'ascii-art:convert'
```

Now reload the window and verify that the key binding works.

#### Add the ASCII Art

Now we need to convert the selected text to ASCII art. To do this we will use the [figlet](https://npmjs.org/package/figlet) Node module from [npm](https://npmjs.org/). Open `package.json` and add the latest version of figlet to the dependencies:

```json
"dependencies": {
  "figlet": "1.0.8"
}
```

After saving the file, run the command "Update Package Dependencies: Update" from the Command Palette. This will install the package's node module dependencies, only figlet in this case. You will need to run "Update Package Dependencies: Update" whenever you update the dependencies field in your _package.json_ file.

If for some reason this doesn't work, you'll see a message saying "Failed to update package dependencies" and you will find a new `npm-debug.log` file in your directory. That file should give you some idea as to what went wrong.

Now require the figlet node module in _lib/ascii-art.coffee_ and instead of inserting 'Hello, World!', convert the selected text to ASCII art.

```coffeescript
convert: ->
  if editor = atom.workspace.getActiveTextEditor()
    selection = editor.getSelectedText()

    figlet = require 'figlet'
    font = "o8"
    figlet selection, {font: font}, (error, art) ->
      if error
        console.error(error)
      else
        editor.insertText("\n#{art}\n")
```

Now reload the editor, select some text in an editor window and hit `ctrl-alt-a`. It should be replaced with a ridiculous ASCII art version instead.

There are a couple of new things in this example we should look at quickly. The first is the [`editor.getSelectedText()`](https://atom.io/docs/api/latest/TextEditor#instance-getSelectedText) which, as you might guess, returns the text that is currently selected.

We then call the Figlet code to convert that into something else and replace the current selection with it with the [`editor.insertText()`](https://atom.io/docs/api/latest/TextEditor#instance-insertText) call.

#### Summary

In this section, we've made a UI-less package that takes selected text and replaces it with a processed version. This could be helpful in creating linters or checkers for your code.
