---
title: How do I make Atom recognize a file with extension X as language Y?
---
### How do I make Atom recognize a file with extension X as language Y?

Atom includes a feature called "custom file types" which you can use by adding some entries into your `config.cson` that look like this:

```coffee
core:
  customFileTypes:
    'source.ruby': [
      'Cheffile'
      'this-is-also-ruby'
    ]
    'source.cpp': [
      'h'
    ]
```

The key (for example `source.ruby` in the above snippet) is the language's [scope name](http://flight-manual.atom.io/using-atom/sections/basic-customization/#finding-a-languages-scope-name). The value is an array of file extensions, without the period, to match to that scope name.
