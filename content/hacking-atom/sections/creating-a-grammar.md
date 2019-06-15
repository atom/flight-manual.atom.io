---
title: Creating a Grammar
---
### Creating a Grammar

Atom's syntax highlighting and code folding system is powered by [Tree-sitter](http://tree-sitter.github.io/tree-sitter). Tree-sitter parsers create and maintain full [_syntax trees_](https://en.wikipedia.org/wiki/Abstract_syntax_tree) representing your code.

This syntax tree gives Atom a comprehensive understanding of the structure of your code, which has several benefits:

1. Syntax highlighting will not break because of formatting changes.
2. Code folding will work regardless of how your code is indented.
3. Editor features can operate on the syntax tree. For instance, the `Select Larger Syntax Node` and `Select Smaller Syntax Node` allow you to select conceptually larger and smaller chunks of your code.
4. Community packages can use the syntax tree to manipulate code intelligently.

Tree-sitter grammars are relatively new. Many languages in Atom are still supported by [TextMate grammars](../creating-a-legacy-textmate-grammar), though we intend to phase these out over time.

If you're adding support for a new language, you're in the right place!

#### Getting Started

There are two components required to use Tree-sitter in Atom: a _parser_ and a _grammar_ file.

#### The Parser

Tree-sitter generates parsers based on [context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar) that are typically written in JavaScript. The generated parsers are C libraries that can be used in other applications as well as Atom.

They can also be developed and tested at the command line, separately from Atom. Tree-sitter has [its own documentation page](http://tree-sitter.github.io/tree-sitter/creating-parsers) on how to create these parsers. The [Tree-sitter GitHub organization](https://github.com/tree-sitter) also contains a lot of example parsers that you can learn from, each in its own repository.

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

Once you have a Tree-sitter parser that is available on npm, you can use it in your Atom package. Packages with grammars are, by convention, always named starting with _language_. You'll need a folder with a `package.json`, a `grammars` subdirectory, and a single `json` or `cson` file in the `grammars` directory, which can be named anything.

```
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
name: 'My Language'
scopeName: 'mylanguage'
type: 'tree-sitter'
parser: 'tree-sitter-mylanguage'
```

* `scopeName` - A unique, stable identifier for the language. Atom users will use this in configuration files if they want to specify custom configuration based on the language.
* `name` - A human readable name for the language.
* `parser` - The name of the parser node module that will be used for parsing. This string will be passed directly to [`require()`](https://nodejs.org/api/modules.html#modules_require) in order to load the parser.
* `type` - This should have the value `tree-sitter` to indicate to Atom that this is a Tree-sitter grammar and not a [TextMate grammar](../creating-a-legacy-textmate-grammar).

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

##### Advanced Selectors

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

##### Text-based Mappings

You can also apply different classes to a syntax node based on its text. Here are some examples:

```coffee
scopes:

  # Apply the classes `syntax--builtin` and `syntax--variable` to all
  # `identifier` nodes whose text is `require`.
  'identifier': {exact: 'require', scopes: 'builtin.variable'},

  # Apply the classes `syntax--type` and `syntax--integer` to all
  # `primitive_type` nodes whose text starts with `int` or `uint`.
  'primitive_type': {match: /^u?int/, scopes: 'type.integer'},

  # Apply the classes `syntax--builtin`, `syntax--class`, and
  # `syntax--name` to `constant` nodes with the text `Array`,
  # `Hash` and `String`. For all other `constant` nodes, just
  # apply the classes `syntax--class` and `syntax--name`.
  'constant': [
    {match: '^(Array|Hash|String)$', scopes: 'builtin.class.name'},
    'class.name'
  ]
```

In total there are four types of values that can be associated with selectors in `scopes`:

* Strings - Each class name in the dot-separated string will be prefixed with `syntax--` and applied to the selected node.
* Objects with the keys `exact` and `scopes` - If the node's text equals the `exact` string, the `scopes` string will be used as described above.
* Objects with the keys `match` and `scopes` - If the node's text matches the `match` regex pattern, the `scopes` string will be used as described above.
* Arrays - The elements of the array will be processed from beginning to end. The first element that matches the selected node will be used as describe above.

##### Specificity

If multiple selectors in the `scopes` object match a node, the node's classes will be decided based on the [most specific](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity) selector. Note that the `exact` and `match` rules do *not* affect specificity, so you may need to supply the same `exact` or `match` rules for multiple selectors to ensure that they take precedence over other selectors. You can use the same selector multiple times in a scope mapping, within different comma-separated keys:

```coffee
scopes:
  'call_expression > identifier': 'entity.name.function'

  # If we did not include the second selector here, then this rule
  # would not apply to identifiers inside of call_expressions,
  # because the selector `call_expression > identifier` is more
  # specific than the selector `identifier`.
  'identifier, call_expression > identifier': [
    {exact: 'require', scopes: 'builtin.variable'},
    {match: '^[A-Z]', scopes: 'constructor'},
  ]
```

#### Language Injection

Sometimes, a source file can contain code written in several different languages. Tree-sitter grammars support this situation using a two-part process called *language injection*. First, an 'outer' language must define an *injection point* - a set of syntax nodes whose text can be parsed using a different language, along with some logic for guessing the *name* of the other language that should be used. Second, an 'inner' language must define an `injectionRegex` - a regex pattern that will be tested against the language name provided by the injection point.

For example, in JavaScript, [tagged template literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#Tagged_templates) sometimes contain code written in a different language, and the name of the language is often used in the 'tag' function, as shown in this example:

```js
// HTML in a template literal
const htmlContent = html `<div>Hello ${name}</div>`
```

The `tree-sitter-javascript` parser parses this tagged template literal as a `call_expression` with two children: an `identifier` and a `template_literal`:

```
(call_expression
  (identifier)
  (template_literal
    (interpolation
      (identifier))))
```

Here is an injection point that would allow syntax highlighting inside of template literals:

```js
atom.grammars.addInjectionPoint('source.js', {
  type: 'call_expression',

  language (callExpression) {
    const {firstChild} = callExpression
    if (firstChild.type === 'identifier') {
      return firstChild.text
    }
  },

  content (callExpression) {
    const {lastChild} = callExpression
    if (lastChild.type === 'template_string') {
      return lastChild
    }
  }
})
```

The `language` callback would then be called with every `call_expression` node in the syntax tree. In the example above, it would retrieve the first child of the `call_expression`, which is an `identifier` with the name "html". The callback would then return the string "html".

The `content` callback would then be called with the same `call_expression` node and return the  `template_string` node within the `call_expression` node.

In order to parse the HTML within the template string, the HTML grammar file would need to specify an `injectionRegex`:

```coffee
injectionRegex: 'html|HTML'
```

#### Code Folding

The next field in the grammar file, `folds`, controls code folding. Its value is an array of *fold pattern* objects. Fold patterns are used to decide whether or not a syntax node can be folded, and if so, where the fold should start and end. Here are some example fold patterns:

```coffee
folds: [

  # All `comment` nodes are foldable. By default, the fold starts at
  # the end of the node's first line, and ends at the beginning
  # of the node's last line.
  {
    type: 'comment'
  }

  # `if_statement` nodes are foldable if they contain an anonymous
  # "then" token and either an `elif_clause` or `else_clause` node.
  # The fold starts at the end of the "then" token and ends at the
  # `elif_clause` or `else_clause`.
  {
    type: 'if_statement',
    start: {type: '"then"'}
    end: {type: ['elif_clause', 'else_clause']}
  }

  # Any node that starts with an anonymous "(" token and ends with
  # an anonymous ")" token is foldable. The fold starts after the
  # "(" and ends before the ")".
  {
    start: {type: '"("', index: 0},
    end: {type: '")"', index: -1}
  }
]
```

Fold patterns can have one or more of the following fields:

* `type` - A string or array of strings. In order to be foldable according to this pattern, a syntax node's type must match one of these strings.
* `start` - An object that is used to identify a *child* node after which the fold should start. The object can have one or both of the following fields:
  * `type` - A string or array of strings. To start a fold, a child node's type must match one of these strings.
  * `index` - a number that's used to select a specific child according to its index. Negative values are interpreted as indices relative the last child, so that `-1` means the last child.
* `end` - An object that is used to identify a *child* node before which the fold should end. It has the same structure as the `start` object.

#### Comments

The last field in the grammar file, `comments`, controls the behavior of Atom's `Editor: Toggle Line Comments` command. Its value is an object with a `start` field and an optional `end` field. The start field is a string that should be prepended to or removed from lines in order to comment or un-comment them.

In JavaScript, it looks like this:

```coffee
comments:
  start: '// '
```

The `end` field should be used for languages that only support block comments, not line comments. If present, it will be appended to or removed from the end of the last selected line in order to comment or un-comment the selection.

In CSS, it would look like this:

```coffee
comments:
  start: '/* '
  end: ' */'
```

#### Example Packages

More examples of all of these features can be found in the Tree-sitter grammars bundled with Atom:

* [Bash](https://github.com/atom/language-shellscript)
* [C](https://github.com/atom/language-c)
* [Go](https://github.com/atom/language-go)
* [HTML](https://github.com/atom/language-html)
* [JavaScript](https://github.com/atom/language-javascript)
* [Python](https://github.com/atom/language-python)
* [Ruby](https://github.com/atom/language-ruby)
* [TypeScript](https://github.com/atom/language-typescript)
