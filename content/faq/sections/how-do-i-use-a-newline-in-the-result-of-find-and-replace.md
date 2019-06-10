---
title: How do I use a newline in the result of find and replace?
---
### How do I use a newline in the result of find and replace?

To use a newline in the result of find and replace, enable the `Use Regex` option and use "\n" in your replacement text.  For example, given this text:

```text
hello, world, goodbye
```

If you'd like to replace the ", " with a newline so you end up with this text:

```text
hello
world
goodbye
```

In the find and replace settings, enable `Use Regex`, enter ", " as the find text, and enter "\n" as the replace text:

![Find and replace with newline replace](../../images/find-and-replace-newline.png)

Then click `Find All` and finally, click `Replace All`.
