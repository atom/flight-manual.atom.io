---
title: Removing Shadow DOM styles
---

### Removing Shadow DOM styles

In Atom `1.13` the Shadow DOM got removed from text editors. For more background on the reasoning, check out the [Pull Request](https://github.com/atom/atom/pull/12903) where it was removed. In this guide you will learn how to migrate your theme or package.


#### Summary

Here a quick summary to see all the changes at a glance:

Before | +/- | After
---|---|---
`atom-text-editor::shadow {}` | - `::shadow` | `atom-text-editor {}`
`.class /deep/ .class {}` | - `/deep/` | `.class .class {}`
`index.atom-text-editor.less` | - `.atom-text-editor` | `index.less`
`atom-text-editor, :host {}` | - `:host` | `atom-text-editor {}`
`.comment {}` | + `.syntax--` | `.syntax--comment {}`

Below you'll find more detailed examples.

#### UI themes and packages


##### `::shadow`

Remove the `::shadow` pseudo-element selector from `atom-text-editor`.

Before:

```less
atom-text-editor::shadow .cursor {
  border-color: hotpink;
}
```

After:

```less
atom-text-editor .cursor {
  border-color: hotpink;
}
```


##### `/deep/`

Remove the `/deep/` combinator selector. It didn't get used that often, mainly to customize the scrollbars.

Before:

```less
.scrollbars-visible-always /deep/ ::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
```

After:

```less
.scrollbars-visible-always ::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
```


##### Context-Targeted Style Sheets

Atom also allowed you to target a specific shadow DOM context with an entire style sheet by adding `.atom-text-editor` to the file name. This is now not necessary anymore and can be removed.

Before:

```
my-ui-theme/
  styles/
    index.atom-text-editor.less
```

After:

```
my-ui-theme/
  styles/
    index.less
```


#### Syntax themes


##### `:host`

Remove the `:host` pseudo-element selector. To scope any styles to the text editor, using `atom-text-editor` is already enough.

Before:

```less
atom-text-editor, :host {
  .cursor {
    border-color: hotpink;
  }
}
```

After:

```less
atom-text-editor {
  .cursor {
    border-color: hotpink;
  }
}
```


##### `syntax--`

Add a `syntax--` prefix to all grammar selectors used by language packages. It looks a bit verbose, but it will protect all the grammar selectors from accidental style pollution.

Before:

```less
.comment {
  color: @mono-3;
  font-style: italic;

  .markup.link {
    color: @mono-3;
  }
}
```

After:

```less
.syntax--comment {
  color: @mono-3;
  font-style: italic;

  .syntax--markup.syntax--link {
    color: @mono-3;
  }
}
```

__Note__: Selectors like the `.gutter`, `.indent-guide`, `.cursor` etc., that also get styled in Syntax themes, don't need a prefix. __Only__ grammar selectors that get used by language packages. E.g. `.syntax--keyword`, `.syntax--keyword.syntax--operator.syntax--js`.
