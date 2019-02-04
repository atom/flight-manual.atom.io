---
title: Scoped Settings, Scopes and Scope Descriptors
---
### Scoped Settings, Scopes and Scope Descriptors

Atom supports language-specific settings. You can soft wrap only Markdown files, or set the tab length to 4 in Python files.

Language-specific settings are a subset of something more general we call "scoped settings". Scoped settings allow targeting down to a specific syntax token type. For example, you could conceivably set a setting to target only Ruby comments, only code inside Markdown files, or even only JavaScript function names.

#### Scope Names in Syntax Tokens

Each token in the editor has a collection of scope names. For example, the aforementioned JavaScript function name might have the scope names `function` and `name`. An open paren might have the scope names `punctuation`, `parameters`, `begin`.

Scope names work just like CSS classes. In fact, in the editor, scope names are attached to a token's DOM node as CSS classes.

Take this piece of JavaScript:

```js
function functionName() {
  console.log('Log it out');
}
```

In the dev tools, the first line's markup looks like this.

![Markup](../../images/markup.png)

All the class names on the spans are scope names. Any scope name can be used to target a setting's value.

#### Scope Selectors

Scope selectors allow you to target specific tokens just like a CSS selector targets specific nodes in the DOM. Some examples:

```coffee
'.source.js' # selects all javascript tokens
'.source.js .function.name' # selects all javascript function names
'.function.name' # selects all function names in any language
```

[`Config::set`](https://atom.io/docs/api/latest/Config#instance-set) accepts a `scopeSelector`. If you'd like to set a setting for JavaScript function names, you can give it the JavaScript function name `scopeSelector`:

```javascript
atom.config.set('my-package.my-setting', 'special value', {scopeSelector: '.source.js .function.name'})
```

#### Scope Descriptors

A scope descriptor is an [Object](https://atom.io/docs/api/latest/ScopeDescriptor) that wraps an `Array` of `String`s. The Array describes a path from the root of the syntax tree to a token including _all_ scope names for the entire path.

In our JavaScript example above, a scope descriptor for the function name token would be:

```javascript
['source.js', 'meta.function.js', 'entity.name.function.js']
```

[`Config::get`](https://atom.io/docs/api/latest/Config#instance-get) accepts a `scopeDescriptor`. You can get the value for your setting scoped to JavaScript function names via:

```javascript
const scopeDescriptor = ['source.js', 'meta.function.js', 'entity.name.function.js']
const value = atom.config.get('my-package.my-setting', {scope: scopeDescriptor})
```

But, you do not need to generate scope descriptors by hand. There are a couple methods available to get the scope descriptor from the editor:

* [`Editor::getRootScopeDescriptor`](https://atom.io/docs/api/latest/TextEditor#instance-getRootScopeDescriptor) to get the language's descriptor. For example: `[".source.js"]`
* [`Editor::scopeDescriptorForBufferPosition`](https://atom.io/docs/api/latest/TextEditor#instance-scopeDescriptorForBufferPosition) to get the descriptor at a specific position in the buffer.
* [`Cursor::getScopeDescriptor`](https://atom.io/docs/api/latest/Cursor#instance-getScopeDescriptor) to get a cursor's descriptor based on position. eg. if the cursor were in the name of the method in our example it would return `["source.js", "meta.function.js", "entity.name.function.js"]`

Let's revisit our example using these methods:

```javascript
const editor = atom.workspace.getActiveTextEditor()
const cursor = editor.getLastCursor()
const valueAtCursor = atom.config.get('my-package.my-setting', {scope: cursor.getScopeDescriptor()})
const valueForLanguage = atom.config.get('my-package.my-setting', {scope: editor.getRootScopeDescriptor()})
```
