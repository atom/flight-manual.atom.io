---
title: Creating a Theme
---
### Creating a Theme

Atom's interface is rendered using HTML, and it's styled via [Less](http://lesscss.org/) which is a superset of CSS. Don't worry if you haven't heard of Less before; it's just like CSS, but with a few handy extensions.

Atom supports two types of themes: _UI_ and _syntax_.  UI themes style elements such as the tree view, the tabs, drop-down lists, and the status bar. Syntax themes style the code inside the editor.

Themes can be installed and changed from the settings view which you can open by selecting the _Atom > Preferences..._ menu and navigating to the _Install_ section and the _Themes_ section on the left hand side.

#### Getting Started

Themes are pretty straightforward but it's still helpful to be familiar with a few things before starting:

* Less is a superset of CSS, but it has some really handy features like variables. If you aren't familiar with its syntax, take a few minutes to [familiarize yourself](https://speakerdeck.com/danmatthews/less-css).
* You may also want to review the concept of a `package.json` (as covered in [Atom `package.json`](/hacking-atom/sections/package-word-count/#atom-package-json)). This file is used to help distribute your theme to Atom users.
* Your theme's `package.json` must contain a `theme` key with a value of `ui` or `syntax` for Atom to recognize and load it as a theme.
* You can find existing themes to install or fork on [atom.io](https://atom.io/themes).

#### Creating a Syntax Theme

Let's create your first theme.

To get started, hit `cmd-shift-P`, and start typing "Generate Syntax Theme" to generate a new theme package. Select "Generate Syntax Theme," and you'll be asked for the path where your theme will be created. Let's call ours _motif-syntax_.

{{#tip}}

Syntax themes should end with _-syntax_ and UI themes should end with _-ui_.

{{/tip}}

Atom will pop open a new window, showing the motif-syntax theme, with a default set of folders and files created for us. If you open the settings view (`cmd-,`) and navigate to the "Themes" section on the left, you'll see the "Motif" theme listed in the _Syntax Theme_ drop-down. Select it from the menu to activate it, now when you open an editor you should see your new motif-syntax theme in action.

Open up `styles/colors.less` to change the various color variables which have already been defined. For example, turn `@red` into `#f4c2c1`.

Then open `styles/base.less` and modify the various selectors that have already been defined. These selectors style different parts of code in the editor such as comments, strings and the line numbers in the gutter.

As an example, let's make the `.gutter` `background-color` into `@red`.

Reload Atom by pressing `cmd-alt-ctrl-l` to see the changes you made reflected in your Atom window. Pretty neat!

{{#tip}}

You can avoid reloading to see changes you make by opening an atom window in dev mode. To open a Dev Mode Atom window run `atom --dev .` in the terminal, use `cmd-shift-o` or use the _View > Developer > Open in Dev Mode_ menu. When you edit your theme, changes will instantly be reflected!

{{/tip}}

{{#note}}

It's advised to _not_ specify a `font-family` in your syntax theme because it will override the Font Family field in Atom's settings. If you still like to recommend a font that goes well with your theme, we recommend you do so in your README.

{{/note}}

#### Creating an Interface Theme

Interface themes **must** provide a `ui-variables.less` file which contains all of the variables provided by the core themes, which we'll cover in [Theme Variables](#theme-variables).

To create an interface UI theme, do the following:

1. Fork one of the following repositories:
  * [atom-dark-ui](https://github.com/atom/atom-dark-ui)
  * [atom-light-ui](https://github.com/atom/atom-light-ui)
2. Clone the forked repository to the local filesystem
3. Open a terminal in the forked theme's directory
4. Open your new theme in a Dev Mode Atom window run `atom --dev .` in the terminal or use the _View > Developer > Open in Dev Mode_ menu
5. Change the name of the theme in the theme's `package.json` file
6. Name your theme end with a `-ui`. i.e. `super-white-ui`
7. Run `apm link` to symlink your repository to `~/.atom/packages`
8. Reload Atom using `cmd-alt-ctrl-L`
9. Enable the theme via _UI Theme_ drop-down in the _Themes_ section of the settings view
10. Make changes! Since you opened the theme in a Dev Mode window, changes will be instantly reflected in the editor without having to reload.

#### Development workflow

There are a few of tools to help make theme development faster and easier.

##### Live Reload

Reloading by hitting `cmd-alt-ctrl-L` after you make changes to your theme is less than ideal. Atom supports [live updating](https://github.com/atom/dev-live-reload) of styles on Dev Mode Atom windows.

To enable a Dev Mode window:

1. Open your theme directory in a dev window by either going to the __View > Developer > Open in Dev Mode__ menu or by hitting the `cmd-shift-o` shortcut
2. Make a change to your theme file and save it. Your change should be immediately applied!

If you'd like to reload all the styles at any time, you can use the shortcut `cmd-ctrl-shift-r`.

##### Developer Tools

Atom is based on the Chrome browser, and supports Chrome's Developer Tools. You can open them by selecting the _View > Toggle Developer Tools_ menu, or by using the `cmd-alt-i` shortcut.

The dev tools allow you to inspect elements and take a look at their CSS properties.

![Developer Tools](../../images/dev-tools.png)

Check out Google's [extensive tutorial](https://developer.chrome.com/devtools/docs/dom-and-styles) for a short introduction.

##### Atom Styleguide

If you are creating an interface theme, you'll want a way to see how your theme changes affect all the components in the system. The [styleguide](https://github.com/atom/styleguide) is a page that renders every component Atom supports.

To open the styleguide, open the command palette (`cmd-shift-P`) and search for "styleguide", or use the shortcut `cmd-ctrl-shift-g`.

![Style Guide](../../images/styleguide.png)

#### Theme Variables

Atom's UI provides a set of variables you can use in your own themes and packages.

##### Use in Themes

Each custom theme must specify a `ui-variables.less` file with all of the following variables defined. The top-most theme specified in the theme settings will be loaded and available for import.

##### Use in Packages

In any of your package's `.less` files, you can access the theme variables by importing the `ui-variables` file from Atom.

Your package should generally only specify structural styling, and these should come from [the style guide](https://github.com/atom/styleguide). Your package shouldn't specify colors, padding sizes, or anything in absolute pixels. You should instead use the theme variables. If you follow this guideline, your package will look good out of the box with any theme!

Here's an example `.less` file that a package can define using theme variables:

```css
@import "ui-variables";

.my-selector {
  background-color: @base-background-color;
  padding: @component-padding;
}
```

##### Variables

###### Text colors

* `@text-color`
* `@text-color-subtle`
* `@text-color-highlight`
* `@text-color-selected`
* `@text-color-info` - A blue
* `@text-color-success`- A green
* `@text-color-warning`- An orange or yellow
* `@text-color-error` - A red

###### Background colors

* `@background-color-info` - A blue
* `@background-color-success` - A green
* `@background-color-warning` - An orange or yellow
* `@background-color-error` - A red
* `@background-color-highlight`
* `@background-color-selected`
* `@app-background-color` - The app's background under all the editor components

###### Component colors

* `@base-background-color` -
* `@base-border-color` -

* `@pane-item-background-color` -
* `@pane-item-border-color` -

* `@input-background-color` -
* `@input-border-color` -

* `@tool-panel-background-color` -
* `@tool-panel-border-color` -

* `@inset-panel-background-color` -
* `@inset-panel-border-color` -

* `@panel-heading-background-color` -
* `@panel-heading-border-color` -

* `@overlay-background-color` -
* `@overlay-border-color` -

* `@button-background-color` -
* `@button-background-color-hover` -
* `@button-background-color-selected` -
* `@button-border-color` -

* `@tab-bar-background-color` -
* `@tab-bar-border-color` -
* `@tab-background-color` -
* `@tab-background-color-active` -
* `@tab-border-color` -

* `@tree-view-background-color` -
* `@tree-view-border-color` -

* `@ui-site-color-1` -
* `@ui-site-color-2` -
* `@ui-site-color-3` -
* `@ui-site-color-4` -
* `@ui-site-color-5` -

###### Component sizes

* `@disclosure-arrow-size` -

* `@component-padding` -
* `@component-icon-padding` -
* `@component-icon-size` -
* `@component-line-height` -
* `@component-border-radius` -

* `@tab-height` -

###### Fonts

* `@font-size` -
* `@font-family` -
