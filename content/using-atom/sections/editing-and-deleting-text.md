---
title: Editing and Deleting Text
---
### Editing and Deleting Text

So far we've looked at a number of ways to move around and select regions of a file, so now let's actually change some of that text. Obviously you can type in order to insert characters, but there are also a number of ways to delete and manipulate text that could come in handy.

#### Basic Manipulation

There are a handful of cool keybindings for basic text manipulation that might come in handy. These range from moving around lines of text and duplicating lines to changing the case.

* <kbd class="platform-mac">Cmd+J</kbd><kbd class="platform-windows platform-linux">Ctrl+J</kbd> - Join the next line to the end of the current line
* <kbd class="platform-mac">Cmd+Ctrl+Up/Down</kbd><kbd class="platform-windows platform-linux">Ctrl+Up/Down</kbd> - Move the current line up or down
* <kbd class="platform-mac">Cmd+Shift+D</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+D</kbd> - Duplicate the current line
* <kbd class="platform-mac">Cmd+K</kbd> <kbd class="platform-mac">Cmd+U</kbd><kbd class="platform-windows platform-linux">Ctrl+K</kbd> <kbd class="platform-windows platform-linux">Ctrl+U</kbd> - Upper case the current word
* <kbd class="platform-mac">Cmd+K</kbd> <kbd class="platform-mac">Cmd+L</kbd><kbd class="platform-windows platform-linux">Ctrl+K</kbd> <kbd class="platform-windows platform-linux">Ctrl+L</kbd> - Lower case the current word

{{#mac}}

* <kbd class="platform-mac">Ctrl+T</kbd> - Transpose characters. This swaps the two characters on either side of the cursor.

{{/mac}}

Atom also has built in functionality to re-flow a paragraph to hard-wrap at a given maximum line length. You can format the current selection to have lines no longer than 80 (or whatever number `editor.preferredLineLength` is set to) characters using <kbd class="platform-mac">Alt+Cmd+Q</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+Q</kbd>. If nothing is selected, the current paragraph will be reflowed.

#### Deleting and Cutting

You can also delete or cut text out of your buffer with some shortcuts. Be ruthless.

* <kbd class="platform-mac platform-windows platform-linux">Ctrl+Shift+K</kbd> - Delete current line
* <span class="platform-mac"><kbd class="platform-mac">Alt+Backspace</kbd> or <kbd class="platform-mac">Alt+H</kbd></span><kbd class="platform-windows platform-linux">Ctrl+Backspace</kbd> - Delete to beginning of word
* <span class="platform-mac"><kbd class="platform-mac">Alt+Delete</kbd> or <kbd class="platform-mac">Alt+D</kbd></span><kbd class="platform-windows platform-linux">Ctrl+Delete</kbd> - Delete to ending of word

{{#mac}}

* <kbd class="platform-mac">Cmd+Delete</kbd> - Delete to end of line
* <kbd class="platform-mac">Ctrl+K</kbd> - Cut to end of line
* <kbd class="platform-mac">Cmd+Backspace</kbd> - Delete to beginning of line

{{/mac}}

#### Multiple Cursors and Selections

One of the cool things that Atom can do out of the box is support multiple cursors. This can be incredibly helpful in manipulating long lists of text.

* <kbd class="platform-mac">Cmd+Click</kbd><kbd class="platform-windows platform-linux">Ctrl+Click</kbd> - Add a new cursor at the clicked location
* <kbd class="platform-mac">Ctrl+Shift+Up/Down</kbd><kbd class="platform-windows">Alt+Ctrl+Up/Down</kbd><kbd class="platform-linux">Alt+Shift+Up/Down</kbd> - Add another cursor above/below the current cursor
* <kbd class="platform-mac">Cmd+D</kbd><kbd class="platform-windows platform-linux">Ctrl+D</kbd> - Select the next word in the document that is the same as the currently selected word
* <kbd class="platform-mac">Cmd+Ctrl+G</kbd><kbd class="platform-windows platform-linux">Alt+F3</kbd> - Select all words in the document that are the same as the currently selected word

{{#mac}}

* <kbd class="platform-mac">Cmd+Shift+L</kbd> - Convert a multi-line selection into multiple cursors

{{/mac}}

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

* <kbd class="platform-mac platform-windows platform-linux">Ctrl+M</kbd> - Jump to the bracket matching the one adjacent to the cursor. It jumps to the nearest enclosing bracket when there's no adjacent bracket.
* <kbd class="platform-mac">Cmd+Ctrl+M</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+M</kbd> - Select all the text inside the current brackets
* <kbd class="platform-mac">Alt+Cmd+.</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+.</kbd> - Close the current XML/HTML tag

The brackets functionality is implemented in the [bracket-matcher](https://github.com/atom/bracket-matcher) package. Like all of these packages, to change defaults related to bracket handling, or to disable it entirely, you can navigate to this package in the Settings view.

#### Encoding

Atom also ships with some basic file encoding support should you find yourself working with non-UTF-8 encoded files, or should you wish to create one.

* <kbd class="platform-mac platform-windows">Ctrl+Shift+U</kbd><kbd class="platform-linux">Alt+U</kbd> - Toggle menu to change file encoding

If you pull up the file encoding dialog, you can choose an alternate file encoding to save your file in.

When you open a file, Atom will try to auto-detect the encoding. If Atom can't identify the encoding, the encoding will default to UTF-8, which is also the default encoding for new files.

![Changing your file encoding](../../images/encodings.png)

If you pull up the encoding menu and change the active encoding to something else, the file will be written out in that encoding the next time you save the file.

The encoding selector is implemented in the [encoding-selector](https://github.com/atom/encoding-selector) package.
