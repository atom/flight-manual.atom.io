---
title: Developing Node Modules
---
### Developing Node Modules

Atom contains a number of packages that are Node modules instead of Atom packages. If you want to make changes to the Node modules, for instance `atom-keymap`, you have to link them into the development environment differently than you would a normal Atom package.

#### Linking a Node Module Into Your Atom Dev Environment

Here are the steps to run a local version of a Node module, *not* an Atom package, within Atom. We're using `atom-keymap` as an example:

``` command-line
$ git clone https://github.com/atom/atom-keymap.git
$ cd atom-keymap
$ npm install
$ npm link

# This is the special step, it makes the Node module work with Atom's version of Node
$ apm rebuild

$ cd <em>WHERE YOU CLONED ATOM</em>
$ npm link atom-keymap

# If you have cloned Atom in a different location than <span class="platform-mac platform-linux">~/github/atom</span><span class="platform-windows">%USERPROFILE%\github\atom</span>
# you need to set the following environment variable
$ <span class="platform-mac platform-linux">export</span><span class="platform-windows">setx</span> ATOM_DEV_RESOURCE_PATH=<em>WHERE YOU CLONED ATOM</em>

# Should work!
$ atom --dev .
```

After you get the Node module linked and working, every time you make a change to the Node module's code, you will have to exit Atom and do the following:

``` command-line
$ cd <em>WHERE YOU CLONED THE NODE MODULE</em>
$ npm install
$ apm rebuild
$ cd <em>WHERE YOU CLONED ATOM</em>
$ atom --dev .
```
