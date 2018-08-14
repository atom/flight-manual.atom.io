---
title: Creating a Tree-sitter Grammar
---
### Creating a Tree-sitter Grammar

[Tree-sitter](http://tree-sitter.github.io/tree-sitter) is a new parsing system that Atom can use for syntax highlighting and code folding. Unlike TextMate grammars, Tree-sitter creates and maintains a full [_syntax tree_](https://en.wikipedia.org/wiki/Abstract_syntax_tree) representing your code. This syntax tree provides Atom with detailed information about the code that can be used for other types of analysis beyond syntax highlighting.

#### Getting Started

There are two components required for syntax highlighting a language with Tree-sitter: a _parser_ and a _grammar_ file.

#### The Parser

Tree-sitter generates parsers based on [context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar) that are typically written in JavaScript. The parsers are C libraries that can be used in applications other than Atom. Tree-sitter has [its own documentation page](http://tree-sitter.github.io/tree-sitter/creating-parsers) on how to create these parsers. The [Tree-sitter GitHub organization](https://github.com/tree-sitter) also contains a lot of example parsers that you can learn from, each in its own repository.

Once you have created a parser, you need to publish it to [the NPM registry](https://npmjs.com) to use it in Atom. To do this, make sure you have a `name` and `version` in your parser's `package.json`:

```js
{
  "name": "tree-sitter-mylanguage",
  "version": "0.0.1",
  // ...
}
```

then run the command `npm publish`.

#### The Package

Once you have a Tree-sitter parser that is available on npm, you can use it in your Atom package. Packages with grammars are usually named starting with _language_. You'll need a folder with a `package.json`, a `grammars` subdirectory, and a single `json` or `cson` file in the `grammars` directory, which can be named anything.

```sh
language-mylanguage
├── LICENSE
├── README.md
├── grammars
│   └── mylanguage.cson
└── package.json
```

#### The Grammar File

The `mylanguage.cson` file specifies how Atom should use the parser you created.

#### Basic Fields

It starts with some required fields:

```coffee
id: 'mylanguage'
name: 'MyLanguage'
type: 'tree-sitter'
parser: 'tree-sitter-mylanguage'
```

* `id` - A unique, stable identifier for the language. Atom users will use this in configuration files if they want to specify custom configuration based on the language.
* `name` - A human readable name for the language.
* `parser` - The name of the parser node module that will be used for parsing. This string will be passed directly to [`require()`](https://nodejs.org/api/modules.html#modules_require) in order to load the parser.
* `type` - This should have the value `tree-sitter` to indicate to Atom that this is a Tree-sitter grammar and not a [TextMate grammar](../creating-a-textmate-grammar).

#### Language Recognition

Next, the file should contain some fields that indicate to Atom *when* this language should be used. These fields are all optional.

* `fileTypes` - An array of filename _suffixes_. The grammar will be used for files whose names end with one of these suffixes. Note that the suffix may be an entire filename.
* `firstLineRegex` - A regex pattern that will be tested against the first line of the file. The grammar will be used if this regex matches.
* `contentRegex` - A regex pattern that will be tested against the contents of the file in order to break ties in cases where *multiple* grammars matched the file using the above two criteria. If the `contentRegex` matches, this grammar will be preferred over another grammar with no `contentRegex`. If the `contentRegex` does *not* match, a grammar with no `contentRegex` will be preferred over this one.

#### Syntax Highlighting

The HTML classes that Atom uses for syntax highlighting do not correspond directly to nodes in the syntax tree. Instead, Tree-sitter grammar files specify *scope mappings* that specify which classes should be applied to which syntax nodes. The `scopes` object controls these scope mappings. Its keys are CSS selectors that select nodes in the syntax tree. Its values can be of several different types.

Here is a simple example:

```coffee
scopes:
  'call_expression > identifier': 'entity.name.function'
```

This entry means that, in the syntax tree, any `identifier` node whose parent is a `call_expression` should be highlighted using three classes: `syntax--entity`, `syntax--name`, and `syntax--function`.

Note that in this selector, we're using the [immediate child combinator](https://developer.mozilla.org/en-US/docs/Web/CSS/Child_selectors) (`>`). Arbitrary descendant selectors without this combinator (for example `'call_expression identifier'`, which would match any `identifier` occurring anywhere within a `call_expression`) are currently not supported.

#### Advanced Selectors

The keys of the `scopes` object can also contain _multiple_ CSS selectors, separated by commas, similar to CSS files. The triple-quote syntax in CSON makes it convenient to write keys like this on multiple lines:

```coffee
scopes:
  '''
  function_declaration > identifier,
  call_expression > identifier,
  call_expression > field_expression > field_identifier
  ''': 'entity.name.function'
```

You can use the [`:nth-child` pseudo-class](https://developer.mozilla.org/en-US/docs/Web/CSS/:nth-child) to select nodes based on their order within their parent. For example, this example selects `identifier` nodes which are the fourth (zero-indexed) child of a `singleton_method` node.

```coffee
scopes:
  'singleton_method > identifier:nth-child(3)': 'entity.name.function'
```

Finally, you can use double-quoted strings in the selectors to select *anonymous* tokens in the syntax tree, like `(` and `:`. See [the Tree-sitter documentation](http://tree-sitter.github.io/tree-sitter/using-parsers#named-vs-anonymous-nodes) for more information about named vs anonymous tokens.

```coffee
scopes:
  '''
    "*",
    "/",
    "+",
    "-"
  ''': 'keyword.operator'
```
