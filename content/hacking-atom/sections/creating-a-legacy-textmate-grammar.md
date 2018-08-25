---
title: Creating a Legacy TextMate Grammar
---
### Creating a Legacy TextMate Grammar

Atom's syntax highlighting can be powered by two types of grammars. If you're adding support for a new language, the preferred way is to [create a Tree-sitter grammar](../creating-a-grammar). Tree-sitter grammars have better performance and provide support for more editor features, such as the `Select Larger Syntax Node` command.

This section describes the Atom's legacy support for TextMate grammars.

TextMate grammars are supported by several popular text editors. They provide a set of _regex_ (regular expression) patterns which are assigned _scopes_. These scopes are then turned into the CSS classes that you can target in syntax themes.

{{#note}}

**Note:** This tutorial is a work in progress.

{{/note}}

#### Getting Started

TextMate Grammars depend heavily on regexes, and you should be comfortable with interpreting and writing regexes before continuing. Note that Atom uses the Oniguruma engine, which is very similar to the PCRE or Perl regex engines. Here are some resources to help you out:

* https://www.regular-expressions.info/tutorial.html provides a comprehensive regex tutorial
* https://www.rexegg.com/regex-quickstart.html contains a cheat sheet for various regex expressions
* https://regex101.com/ or https://regexr.com/ allows live prototyping
* https://github.com/kkos/oniguruma/blob/master/doc/RE the docs for the Oniguruma regex engine

Grammar files are written in the [CSON](https://github.com/bevry/cson#what-is-cson) or [JSON](https://www.json.org/) format. Whichever one you decide to use is up to you, but this tutorial will be written in CSON.

#### Create the Package

To get started, press <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> and start typing "Generate Package" to generate a new grammar package. Select "Package Generator: Generate Package," and you'll be asked for the path where your package will be created. Let's call ours `language-flight-manual`.

{{#tip}}

**Tip:** Grammar packages should start with _language-_.

{{/tip}}

The default package template creates a lot of folders that aren't needed for grammar packages. Go ahead and delete the `keymaps`, `lib`, `menus`, and `styles` folders. Furthermore, in `package.json`, remove the `activationCommands` section. Now create a new folder called `grammars`, and inside that a file called `flight-manual.cson`. This is the main file that we will be working with - start by populating it with a [boilerplate template](https://gist.github.com/DamnedScholar/622926bcd222eb1ddc483d12103fd315). Now let's go over what each key means.

`scopeName` is the root _scope_ of your package. This should generally describe what language your grammar package is highlighting; for example, `language-javascript`'s `scopeName` is `source.js` and `language-html`'s is `text.html.basic`. Name it `source.flight-manual` for now.

`name` is the user-friendly name that is displayed in places like the status bar or the grammar selector. Again, this name should describe what the grammar package is highlighting. Rename it to `Flight Manual`.

`fileTypes` is an array of filetypes that `language-flight-manual` should highlight. We're interested in highlighting the Flight Manual's Markdown files, so add the `md` extension to the list and remove the others.

`patterns` contains the array of regex patterns that will determine how the file is tokenized.

#### Adding Patterns

To start, let's add a basic pattern to tokenize the words `Flight Manual` whenever they show up. Your regex should look like `\bFlight Manual\b`. Here's what your `patterns` block should look like:
```coffee
'patterns': [
  {
    'match': '\\bFlight Manual\\b'
    'name': 'entity.other.flight-manual'
  }
]
```

`match` is where your regex is contained, and `name` is the scope name that is to be applied to the entirety of the match. More information about scope names can be found in [Section 12.4 of the TextMate Manual](https://manual.macromates.com/en/language_grammars).

{{#tip}}

**Tip:** All scopes should end with the portion of the root `scopeName` after the leading `source` or `text`. In our case, all scopes should end with `flight-manual`.

{{/tip}}

{{#note}}

**Note:** Astute readers may have noticed that the `\b` was changed to `\\b` with two backslashes and not one. This is because CSON processes the regex string before handing it to Oniguruma, so all backslashes need to be escaped twice.

{{/note}}

But what if we wanted to apply different scopes to `Flight` and `Manual`? This is possible by adding capture groups to the regex and then referencing those capture groups in a new `capture` property. For example:
```coffee
'match': '\\b(Flight) (Manual)\\b'
'name': 'entity.other.flight-manual'
'captures':
  '1':
    'name': 'keyword.other.flight.flight-manual'
  '2':
    'name': 'keyword.other.manual.flight-manual'
```

This will assign the scope `keyword.other.flight.flight-manual` to `Flight`, `keyword.other.manual.flight-manual` to `Manual`, and `entity.other.flight-manual` to the overarching `Flight Manual`.

#### Begin/End Patterns

Now let's say we want to tokenize the `{{#note}}` blocks that occur in Flight Manual files. Our previous two examples used `match`, but one limit of `match` is that it can only match single lines. `{{#note}}` blocks, on the other hand, can span multiple lines. For these cases, you can use the `begin`/`end` keys. Once the regex in the `begin` key is matched, tokenization will continue until the `end` pattern is reached.
```coffee
'begin': '({{)(#note)(}})'
'beginCaptures':
  '0': # The 0 capture contains the entire match
    'name': 'meta.block.start.flight-manual'
  '1':
    'name': 'punctuation.definition.block.flight-manual'
  '2':
    'name': 'keyword.note.flight-manual'
  '3':
    'name': 'punctuation.definition.block.flight-manual'
'end': '({{)(/note)(}})'
'endCaptures':
  '0':
    'name': 'meta.block.end.flight-manual'
  '1':
    'name': 'punctuation.definition.block.flight-manual'
  '2':
    'name': 'keyword.note.flight-manual'
  '3':
    'name': 'punctuation.definition.block.flight-manual'
'name': 'meta.block.note.flight-manual'
```

{{#tip}}

**Tip:** Get into the habit of providing punctuation scopes early on. It's much less effort than having to go back and rewriting all your patterns to support punctuation scopes when your grammar starts to get a bit longer!

{{/tip}}

Awesome, we have our first multiline pattern! However, if you've been following along and playing around in your own `.md` file, you may have noticed that `Flight Manual` doesn't receive any scopes inside a note block. A begin/end block is essentially a subgrammar of its own: once it starts matching, it will only match its own subpatterns until the end pattern is reached. Since we haven't defined any subpatterns, then clearly nothing will be matched inside of a note block. Let's fix that!
```coffee
'begin': '({{)(#note)(}})'
'beginCaptures':
  '0': # The 0 capture contains the entire match
    'name': 'meta.block.start.flight-manual'
  '1':
    'name': 'punctuation.definition.block.flight-manual'
  '2':
    'name': 'keyword.note.flight-manual'
  '3':
    'name': 'punctuation.definition.block.flight-manual'
'end': '({{)(/note)(}})'
'endCaptures':
  '0':
    'name': 'meta.block.end.flight-manual'
  '1':
    'name': 'punctuation.definition.block.flight-manual'
  '2':
    'name': 'keyword.note.flight-manual'
  '3':
    'name': 'punctuation.definition.block.flight-manual'
'name': 'meta.block.note.flight-manual'
'patterns': [
  {
    'match': '\\b(Flight) (Manual)\\b'
    'name': 'entity.other.flight-manual'
    'captures':
      '1':
        'name': 'keyword.other.flight.flight-manual'
      '2':
        'name': 'keyword.other.manual.flight-manual'
  }
]
```

There. With the patterns block, `Flight Manual` should now receive the proper scopes.

#### Repositories and the Include keyword, or how to avoid duplication

At this point, note blocks are looking pretty nice, as is the `Flight Manual` keyword, but the rest of the file is noticeably lacking any form of Markdown syntax highlighting. Is there a way to include the GitHub-Flavored Markdown grammar without copying and pasting everything over? This is where the `include` keyword comes in. `include` allows you to _include_ other patterns, even from other grammars! `language-gfm`'s `scopeName` is `source.gfm`, so let's include that. Our `patterns` block should now look like the following:
```coffee
'patterns': [
  {
    'include': 'source.gfm'
  }
  {
    # Flight Manual pattern
  }
  {
    # Note begin/end pattern
  }
]
```

However, including `source.gfm` has led to another problem: note blocks still don't have any Markdown highlighting! The quick fix would be to add the include pattern to the note's pattern block as well, but now we're duplicating two patterns. You can imagine that as this grammar grows it'll quickly become inefficient to keep copying each new global pattern over to the `note` pattern as well. Therefore, `include` helpfully recognizes the special `$self` scope. `$self` automatically includes all the top-level patterns of the current grammar. The `note` block can then be simplified to the following:
```coffee
'begin': '({{)(#note)(}})'
# beginCaptures
'end': '({{)(/note)(}})'
# endCaptures
'name': 'meta.block.note.flight-manual'
'patterns': [
  {
    'include': '$self'
  }
]
```

#### Where to Go from Here

There are several good resources out there that help when writing a grammar. The following is a list of some particularly useful ones (some have been linked to in the sections above as well).

- [DamnedScholar's Gist](https://gist.github.com/DamnedScholar/622926bcd222eb1ddc483d12103fd315). Provides a template of most keys, each with a short comment explaining their function.
- [Aerijo's Gist](https://gist.github.com/Aerijo/b8c82d647db783187804e86fa0a604a1). [Work in Progress] Another guide that attempts to fully explain making a grammar package for users of all levels.
- http://www.apeth.com/nonblog/stories/textmatebundle.html. A blog of a programmer's experience writing a grammar package for TextMate.
- [Oniguruma docs](https://github.com/kkos/oniguruma/blob/master/doc/RE). The documentation for the regex engine Atom uses.
- [TextMate Section 12](http://manual.macromates.com/en/language_grammars.html). Atom uses the same principles as laid out here, including the list of acceptable scopes.
- [`first-mate`](https://github.com/atom/first-mate). Not necessary to write a grammar, but a good technical reference for what Atom is doing behind the scenes.
- Look at any existing packages, such as the ones for [Python](https://github.com/atom/language-python), [JavaScript](https://github.com/atom/language-javascript), [HTML](https://github.com/atom/language-html), [and more](https://github.com/atom?utf8=%E2%9C%93&q=language&type=source&language=).


<!--
TODO:
* `repository` and including from repository patterns
* Wrap-up
* Implement Package Generator functionality to generate a grammar
* Intermediate + advanced grammar tutorials
-->
