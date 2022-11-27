---
title: I'm trying to change my syntax colors from styles.less, but it isn't working!
---
### I'm trying to change my syntax colors from styles.less, but it isn't working!

The best way to tweak the syntax is to wrap your syntax style rules with `atom-text-editor` and then prepend every scope with `syntax--`. If you want your comments to be blue, for example, you would do the following:

```less
atom-text-editor {
  .syntax--comment {
    color: blue;
  }
}
```
