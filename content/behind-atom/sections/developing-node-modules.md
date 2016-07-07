---
title: Developing Node Modules
---
### Developing Node Modules

Atom contains a number of packages that are Node modules instead of Atom packages. If you want to make changes to the Node modules, for instance `atom-keymap`, you have to link them into the development environment differently than you would a normal Atom package.

#### Linking a Node Module Into Your Atom Dev Environment

Here are the steps to run a local version of a node module *not an apm* within Atom. We're using `atom-keymap` as an example:

``` command-line
$ git clone https://github.com/atom/atom-keymap.git
$ cd atom-keymap
$ npm install
$ npm link

# This is the special step, it makes the npm work with Atom's version of Node
$ apm rebuild

$ cd WHERE-YOU-CLONED-ATOM
$ npm link atom-keymap

# Should work!
$ atom
```

After this, you'll have to `npm install` and `apm rebuild` when you make a change to the node module's code.
