---
title: Contributing to Official Atom Packages
---
### Contributing to Official Atom Packages

If you think you know which package is causing the issue you are reporting, feel free to open up the issue in that specific repository instead. When in doubt just open the issue on the [atom/atom](https://github.com/atom/atom) repository but be aware that it may get closed and reopened in the proper package's repository.

#### Hacking on Packages

##### Cloning

The first step is creating your own clone. For some packages, you may also need to install the [requirements necessary for building Atom](/hacking-atom/sections/hacking-on-atom-core/#building) in order to run `apm install`.

For example, if you want to make changes to the `tree-view` package, fork the repo on your github account, then clone it:

``` command-line
$ git clone git@github.com:<em>your-username</em>/tree-view.git
```

Next install all the dependencies:

``` command-line
$ cd tree-view
$ apm install
> Installing modules ✓
```

Now you can link it to development mode so when you run an Atom window with `atom --dev`, you will use your fork instead of the built in package:

``` command-line
$ apm link -d
```

##### Running in Development Mode

Editing a package in Atom is a bit of a circular experience: you're using Atom to modify itself. What happens if you temporarily break something? You don't want the version of Atom you're using to edit to become useless in the process. For this reason, you'll only want to load packages in **development mode** while you are working on them. You'll perform your editing in **stable mode**, only switching to development mode to test your changes.

To open a development mode window, use the "Application: Open Dev" command. You can also run dev mode from the command line with `atom --dev`.

To load your package in development mode, create a symlink to it in `~/.atom/dev/packages`. This occurs automatically when you clone the package with `apm develop`. You can also run `apm link --dev` and `apm unlink --dev` from the package directory to create and remove dev-mode symlinks.

##### Installing Dependencies

You'll want to keep dependencies up to date by running `apm update` after pulling any upstream changes.
