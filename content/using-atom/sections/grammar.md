---
title: Grammar
---
### Grammar

The "grammar" of a file is what language Atom has associated with that file. Types of grammars would include "Java" or "GitHub-Flavored Markdown". We looked at this a bit when we created some snippets in [Snippets](/using-atom/sections/snippets/).

When you load a file, Atom does a little work to try to figure out what type of file it is. Largely this is accomplished by looking at its file extension (`.md` is generally a Markdown file, etc), though sometimes it has to inspect the content a bit to figure it out.

When you open a file and Atom can't determine a grammar for the file, it will default to "Plain Text", which is the simplest one. If it does default to "Plain Text", picks the wrong grammar for the file, or if for any reason you wish to change the selected grammar, you can pull up the Grammar Selector with <kbd class="platform-all">Ctrl+Shift+L</kbd>.

![Grammar Selector](../../images/grammar.png "Grammar Selector")

When the grammar of a file is changed, Atom will remember that for the current session.

The Grammar Selector functionality is implemented in the [grammar-selector](https://github.com/atom/atom/tree/master/packages/grammar-selector) package.
