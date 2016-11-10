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

__Note__: Selectors like the `.gutter`, `.indent-guide`, `.cursor` among others, that are also part of Syntax themes, don't need a prefix. __Only__ grammar selectors that get used by language packages. For example `.syntax--keyword`, `.syntax--keyword.syntax--operator.syntax--js`.


#### Context-Targeted Style Sheets

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


#### I followed the guide, but now my styling is broken!

By replacing `atom-text-editor::shadow` with `atom-text-editor.editor`, specificity might have changed. This can cause the side effect that some of your properties won't be strong enough. To fix that, you can increase specificity on your selector. A simple way is to just repeat your class (in the example below it's `.my-class`):

Before:

```less
atom-text-editor::shadow .my-class {
  color: hotpink;
}
```

After:

```less
atom-text-editor .my-class.my-class {
  color: hotpink;
}
```


#### When should I migrate my theme/package?

- If you already want to test the migration on master or Beta channel, make sure to change your `package.json` file to `"engines": { "atom": ">=1.13.0 <2.0.0" }`. This will prevent Atom from updating your theme or package before the user also updates Atom to version `1.13`.
- Or you can wait until Atom `1.13` reaches __Stable__. Check [blog.atom.io](http://blog.atom.io/) to see if `1.13` already has been released. Don't worry if you're a bit late, Atom will transform the deprecated selectors automatically to avoid breaking any themes or packages. But users will start to see a deprecation warning in [deprecation-cop](https://github.com/atom/deprecation-cop).
