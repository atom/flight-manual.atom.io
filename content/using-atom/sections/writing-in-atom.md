---
title: Writing in Atom
---
### Writing in Atom

Though it is probably most common to use Atom to write software code, Atom can also be used to write prose quite effectively. Most often this is done in some sort of markup language such as Asciidoc or [Markdown](https://help.github.com/articles/about-writing-and-formatting-on-github/) (in which this manual is written). Here we'll quickly cover a few of the tools Atom provides for helping you write prose.

In these docs, we'll concentrate on writing in Markdown; however, other prose markup languages like Asciidoc have packages that provide similar functionality.

#### Spell Checking

If you're working in text (which includes plain text files, GitHub markdown, and Git commit messages by default), Atom will automatically try to check your spelling.

Any misspelled words will be highlighted (by default with a dashed red line beneath the word), and you can pull up a menu of possible corrections by hitting <kbd class="platform-mac">Cmd+Shift+;</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+;</kbd> (or by choosing "Correct Spelling" from the right-click context menu or from the Command Palette).

![Checking your spelling](../../images/spellcheck.png)

To add more types of files to the list of what Atom will try to spell check, go to the Spell Check package settings in your Settings view and add any grammars you want to spell check.

The default grammars to spell check are `text.plain`, `source.gfm`, `text.git-commit`, `source.asciidoc`, `source.rst`, and `text.restructuredtext` but you can add other grammars if you wish to check those types of files too.

The spell checking is implemented in the [spell-check](https://github.com/atom/spell-check) package.

#### Previews

When writing prose in a markup language, it's often very useful to get an idea of what the content will look like when it's rendered. Atom ships with a package for previewing Markdown by default.

* <kbd class="platform-mac platform-windows platform-linux">Ctrl+Shift+M</kbd> - Will toggle Preview mode for Markdown.

![Preview your prose](../../images/preview.png)

As you edit the text, the preview will also update automatically. This makes it fairly easy to check your syntax as you type.

You can also copy the rendered HTML from the preview pane into your system clipboard when the preview is focused and you press <kbd class="platform-mac">Cmd+C</kbd><kbd class="platform-windows">Ctrl+C</kbd><kbd class="platform-linux">Ctrl+Ins</kbd> or if you right-click in the preview pane and choose "Copy as HTML".

Markdown preview is implemented in the [markdown-preview](https://github.com/atom/markdown-preview) package.

#### Snippets

There are also a number of great snippets available for writing Markdown quickly.

If you type `img` and hit `tab` you get a Markdown-formatted image embed code like `![]()`. If you type `table` and hit `tab` you get a nice example table to fill out.

```markdown
| Header One     | Header Two     |
| :------------- | :------------- |
| Item One       | Item Two       |
```

Although there are only a handful of Markdown snippets (`b` for bold, `i` for italic, `code` for a code block, etc), they save you from having to look up the more obscure syntaxes. Again, you can easily see a list of all available snippets for the type of file you're currently in by choosing "Snippets: Available" in the Command Palette.
