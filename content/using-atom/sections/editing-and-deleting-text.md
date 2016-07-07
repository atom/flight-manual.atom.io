---
title: Editing and Deleting Text
---
### Editing and Deleting Text

So far we've looked at a number of ways to move around and select regions of a file, so now let's actually change some of that text. Obviously you can type in order to insert characters, but there are also a number of ways to delete and manipulate text that could come in handy.

#### Basic Manipulation

There are a handful of cool keybindings for basic text manipulation that might come in handy. These range from moving around lines of text and duplicating lines to changing the case.

`ctrl-T`:: Transpose characters. This swaps the two characters on either side of the cursor.

`cmd-J`:: Join the next line to the end of the current line

`ctrl-cmd-up`, `ctrl-cmd-down`:: Move the current line up or down

`cmd-shift-D`:: Duplicate the current line

`cmd-K, cmd-U`:: Upper case the current word

`cmd-K, cmd-L`:: Lower case the current word

Atom also has built in functionality to re-flow a paragraph to hard-wrap at a given maximum line length. You can format the current selection to have lines no longer than 80 (or whatever number `editor.preferredLineLength` is set to) characters using `cmd-alt-Q`. If nothing is selected, the current paragraph will be reflowed.

#### Deleting and Cutting

You can also delete or cut text out of your buffer with some shortcuts. Be ruthless.

`ctrl-shift-K`:: Delete current line

`cmd-delete`:: Delete to end of line (`cmd-fn-backspace` on mac)

`ctrl-K`:: Cut to end of line

`cmd-backspace`:: Delete to beginning of line

`alt-backspace`, `alt-H`:: Delete to beginning of word

`alt-delete`, `alt-D`:: Delete to end of word

#### Multiple Cursors and Selections

One of the cool things that Atom can do out of the box is support multiple cursors. This can be incredibly helpful in manipulating long lists of text.

`cmd-click`:: Add new cursor

`cmd-shift-L`:: Convert a multi-line selection into multiple cursors

`ctrl-shift-up`, `ctrl-shift-down`:: Add another cursor above/below the current cursor

`cmd-D`:: Select the next word in the document that is the same as the currently selected word

`ctrl-cmd-G`:: Select all words in a document that are the same as the one under the current cursor(s)

Using these commands you can place cursors in multiple places in your document and effectively execute the same commands in multiple places at once.

![Using multiple cursors](../../images/multiple-cursors.gif)

This can be incredibly helpful in doing many type of repetitive tasks such as renaming variables or changing the format of some text. You can use this with almost any plugin or command - for example, changing case and moving or duplicating lines.

You can also use the mouse to select text with the `command` key pressed down to select multiple regions of your text simultaneously.

#### Whitespace

Atom comes with several commands to help you manage the whitespace in your document. One very useful pair of commands converts leading spaces into tabs and converts leading tabs into spaces. If you're working with a document that has mixed whitespace, these commands are great for helping to normalize the file. There are no keybindings for the whitespace commands, so you will have to search your command palette for "Convert Spaces to Tabs" (or vice versa) to run one of these commands.

The whitespace commands are implemented in the [atom/whitespace](https://github.com/atom/whitespace) package. The settings for the whitespace commands are managed on the page for the `whitespace` package.

![Managing your whitespace settings](../../images/whitespace.png)

{{#note}}

The "Remove Trailing Whitespace" option is on by default. This means that every time you save any file opened in Atom, it will strip all trailing whitespace from the file. If you want to disable this, go to the `whitespace` package in your settings panel and uncheck that option.

{{/note}}

Atom will also by default ensure that your file has a trailing newline. You can also disable this option on that screen.

#### Brackets

Atom ships with intelligent and easy to use bracket handling.

It will by default highlight `[]`, `()`, and `{}` style brackets when your cursor is over them. It will also highlight matching XML and HTML tags.

Atom will also automatically autocomplete `[]`, `()`, and `{}`, `""`, `''`, `“”`, `‘’`, `«»`, `‹›`, and backticks when you type the leading one. If you have a selection and you type any of these opening brackets or quotes, Atom will enclose the selection with the opening and closing brackets or quotes.

There are a few other interesting bracket related commands that you can use.

`ctrl-m`:: Jump to the bracket matching the one adjacent to the cursor. It jumps to the nearest enclosing bracket when there's no adjacent bracket.

`ctrl-cmd-m`:: Select all the text inside the current brackets

`alt-cmd-.`:: Close the current XML/HTML tag

The brackets functionality is implemented in the [atom/bracket-matcher](https://github.com/atom/bracket-matcher) package. Like all of these packages, to change defaults related to bracket handling, or to disable it entirely, you can navigate to this package in the Settings view.

#### Encoding

Atom also ships with some basic file encoding support should you find yourself working with non-UTF-8 encoded files, or should you wish to create one.

`ctrl-shift-U`:: Toggle menu to change file encoding

If you pull up the file encoding dialog, you can choose an alternate file encoding to save your file in.

When you open a file, Atom will try to auto-detect the encoding. If Atom can't identify the encoding, the encoding will default to UTF-8, which is also the default encoding for new files.

![Changing your file encoding](../../images/encodings.png)

If you pull up the encoding menu and change the active encoding to something else, the file will be written out in that encoding the next time you save the file.

The encoding selector is implemented in the [atom/encoding-selector](https://github.com/atom/encoding-selector) package.
