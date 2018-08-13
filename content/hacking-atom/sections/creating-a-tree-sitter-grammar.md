---
title: Creating a Tree-sitter Grammar
---
### Creating a Tree-sitter Grammar

[Tree-sitter](http://tree-sitter.github.io/tree-sitter) is a new parsing system that Atom can use for syntax highlighting and code folding. Unlike TextMate grammars, Tree-sitter creates and maintains a full [_syntax tree_](https://en.wikipedia.org/wiki/Abstract_syntax_tree) representing your code. This syntax tree provides Atom with detailed information about the code that can be used for other types of analysis beyond syntax highlighting.

#### Getting Started

There are two components required for syntax highlighting a language with Tree-sitter: a _parser_ and a _grammar_ file.

##### Writing a parser

Tree-sitter generates parsers based on [context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar) that are typically written in JavaScript. The parsers are C libraries that can be used in applications other than Atom. Tree-sitter has [its own documentation](http://tree-sitter.github.io/tree-sitter/creating-parsers) on how to create these parsers.

Once you have created a parser based on the Tree-sitter documentation, you need to publish your parser to [the NPM registry](https://npmjs.com) to use it in Atom.
