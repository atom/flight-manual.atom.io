---
title: Maintaining a Fork of a Core Package in atom/atom
---
### Maintaining a Fork of a Core Package in atom/atom

Originally, each of Atom's core packages resided in a separate repository. In 2018, in an effort to streamline the development of Atom by reducing overhead, the Atom team [consolidated many core Atom packages][consolidation] into the [atom/atom repository][atom-repo]. For example, the one-light-ui package was originally maintained in the [atom/one-light-ui][one-light-ui-repo] repository, but it is now maintained in the [`packages/one-light-ui` directory in the atom/atom repository][one-light-ui-dir].

If you forked one of the core packages before it was moved into the atom/atom repository, and you want to continue merging upstream changes into your fork, please follow the steps below.

#### Step-by-step guide

For the sake of this guide, let's assume that you forked the [atom/one-light-ui][one-light-ui-repo] repository, renamed your fork to `one-light-ui-plus`, and made some customizations.

##### Add atom/atom as a Remote

Navigate to your local clone of your fork:

``` command-line
$ cd path/to/your/fork
```

Add the [atom/atom repository][atom-repo] as a git remote:

``` command-line
$ git remote add upstream https://github.com/atom/atom.git
```

##### Get the Latest Changes for the Core Package

{{#tip}}

**Tip:** Follow these steps each time you want to merge upstream changes into your fork.

{{/tip}}

Fetch the latest changes from the atom/atom repository:

``` command-line
$ git fetch upstream
```

Identify recent changes to the core package. For example, if you're maintaining a fork of the one-light-ui package, then you'll want to identify recent changes in the `packages/one-light-ui` directory:

``` command-line
$ git log upstream/master -- packages/one-light-ui
8ac9919a0 Bump up border size (Hugh Baht, 17 minutes ago)
3bf4d226e Remove obsolete build status link in one-light-ui README (Jason Rudolph, 3 days ago)
3edf64ad0 Merge pull request #42 from atom/sm-select-list (simurai, 2 weeks ago)
...
```

Look through the log and identify the commits that you want to merge into your fork.

##### Merge Upstream Changes into Your Fork

For each commit that you want to bring into your fork, use [`git format-patch`][git-format-patch] in conjunction with [`git am`][git-am]. For example, to merge commit `8ac9919a0` into your fork:

``` command-line
$ git format-patch -1 --stdout 8ac9919a0 | git am -p3
```

Repeat this step for each commit that you want to merge into your fork.

[atom-repo]: https://github.com/atom/atom
[one-light-ui-repo]: https://github.com/atom/one-light-ui
[one-light-ui-dir]: https://github.com/atom/atom/tree/master/packages/one-light-ui
[consolidation]: https://github.com/atom/atom/blob/master/docs/rfcs/003-consolidate-core-packages.md
[git-am]: https://git-scm.com/docs/git-am
[git-format-patch]: https://git-scm.com/docs/git-format-patch
