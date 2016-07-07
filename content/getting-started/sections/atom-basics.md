---
title: Atom Basics
---
### Atom Basics

Now that Atom is installed on your system, let's fire it up, configure it and get acquainted with the editor.

When you launch Atom for the first time, you should get a screen that looks like this:

![Atom's welcome screen](../../images/first-launch.png)

This is the Atom welcome screen and gives you a pretty good starting point for how to get started with the editor.

#### Basic Terminology

First of all, let's get acquainted with some of the terminology we'll be using in this manual.

* **Buffer**

    A buffer is the text content of a file in Atom. It's basically the same as a file for most descriptions, but it's the version Atom has in memory. For instance, you can change the text of a buffer and it isn't written to its associated file until you save it.

* **Pane**

    A pane is a visual section of Atom. If you look at the welcome screen we just launched, you can see four Panes - the tab bar, the gutter (which has line numbers in it), the status bar at the bottom and finally the text editor.

#### Command Palette

In that welcome screen, we are introduced to probably the most important command in Atom, the "Command Palette". If you hit `cmd-shift-P` while focused in an editor pane, the command palette will pop up.

{{#note}}

Throughout the book we will use shortcut keybindings like `cmd-shift-P` to demonstrate how to run a command.
These are the default keybindings for Atom on Mac. They may occasionally be slightly different depending on your platform.

You can use the Command Palette to look up the correct keybindings if it doesn't work for some reason.

{{/note}}

This search-driven menu can do just about any major task that is possible in Atom. Instead of clicking around all the application menus to look for something, you can just hit `cmd-shift-P` and search for the command.

![The Command Palette](../../images/command-palette.png)

Not only can you see and quickly search through thousands of possible commands, but you can also see if there is a keybinding associated with it. This is great because it means you can guess your way to doing interesting things while also learning the shortcut key strokes for doing it.

For the rest of the book, we will try to be clear as to the text you can search for in the Command Palette in addition to the keybinding for different commands.

#### Settings and Preferences

Atom has a number of settings and preferences you can modify on its Settings screen.

![Atom's settings screen](../../images/settings.png)

This includes things like changing the color scheme or theme, specifying how to handle wrapping, font settings, tab size, scroll speed and much more. You can also use this screen to install new packages and themes, which we'll cover in link:/using-atom/sections/atom-packages[Atom Packages].

To open the Settings screen, you can go to the 'Preferences' menu item under the main `Atom` menu in the menu bar. You can also search for `settings-view:open` in the command palette or use the `cmd-,` keybinding.

##### Changing the Color Theme

The Settings view also lets you change the color themes for Atom. Atom ships with 4 different UI color themes, dark and light variants of the Atom and One theme, as well as 8 different syntax color themes. You can modify the active theme or install new themes by clicking on the "Themes" menu item in the sidebar of the Settings view.

![Changing the theme from the Settings View](../../images/theme.png)

The UI themes modify the color of UI elements like the tabs and the tree view, while the syntax themes modify the syntax highlighting of text you load into the editor. To change the theme, simply pick something different in the dropdowns.

There are also dozens of themes on Atom.io that you can choose from if you want something different. We will also cover customizing a theme in [Style Tweaks](/using-atom/sections/basic-customization) and creating your own theme in [Creating a Theme](/hacking-atom/sections/creating-a-theme).

##### Soft Wrap

You can also use the Settings view to specify your whitespace and wrapping preferences.

![Whitespace and wrapping preferences settings](../../images/settings-wrap.png)

Enabling "Soft Tabs" will insert spaces instead of actual tab characters when you hit the `tab` key and the "Tab Length" specifies how many spaces to insert when you do so, or how many spaces to represent a tab as if "Soft Tabs" is disabled.

The "Soft Wrap" option will wrap lines that are too long to fit in your current window. If soft wrapping is disabled, the lines will simply run off the side of the screen and you will have to scroll the window to see the rest of the content. If "Soft Wrap At Preferred Line Length" is toggled, the lines will wrap at 80 characters instead of the end of the screen. You can also change the default line length to a value other than 80 on this screen.

In link:/using-atom/sections/basic-customization[Basic Customization] we will see how to set different wrap preferences for different types of files (for example, if you want to wrap Markdown files but not code files).

##### Beta Features

As Atom is developed, there are occasionally new features that are tested before they are mainlined for everyone. In some cases, those changes are shipped turned off by default but can be enabled in the Settings view should you wish to try them out.

![Beta features in the Settings View](../../images/advanced-settings.png)

This is mainly useful for Package developers to get access to a feature or change before it ships to the general population to ensure their package still works with the new functionality.  However, it may be interesting to try some of these features out occasionally if you're interested in what's coming soon.

#### Opening, Modifying and Saving Files

Now that your editor is looking and acting how you want, let's start opening up and editing files. This is a text editor after all, right?

##### Opening a File

There are several ways to open a file in Atom. You can do it by choosing "File >> Open" from the menu bar or by hitting `cmd-O` to choose a file from the system dialog.

![Open file by dialog](../../images/open-file.png)

This is useful for opening a file that is not contained in the project you're currently in (more on that next), or if you're starting from a new window for some reason.

Another way to open a file in Atom is from the command line using the `atom` command. If you're on a Mac, the Atom menu bar has a command named "Install Shell Commands" which installs the `atom` and `apm` commands [if Atom wasn't able to install them itself](/getting-started/sections/installing-atom/#_installing_atom_on_mac). On Windows and Linux, the `atom` and `apm` commands are installed automatically as a part of Atom's [installation process](/getting-started/sections/installing-atom/).

You can run the `atom` command with one or more file paths to open up those files in Atom.

``` command-line
$ atom -h
> Atom Editor v0.152.0

> Usage: atom [options] [path ...]

> One or more paths to files or folders may be specified. If there is an
> existing Atom window that contains all of the given folders, the paths
> will be opened in that window. Otherwise, they will be opened in a new
> window.

> ...
```

This is a great tool if you're used to the terminal or you work from the terminal a lot. Just fire off `atom [files]` and you're ready to start editing.

##### Editing and Saving a File

Editing a file is pretty straightforward. You can click around and scroll with your mouse and type to change the content. There is no special editing mode or key commands.

To save a file you can choose "File >> Save" from the menu bar or `cmd-s` to save the file. If you choose "Save As" or hit `cmd-shift-s` then you can save the current content in your editor under a different file name. Finally, you can choose `cmd-alt-s` to save all the open files in Atom.

#### Opening Directories

Atom doesn't just work with single files though; you will most likely spend most of your time working on projects with multiple files. To open a directory, choose the menu item "File >> Open" on OS X or "File >> Open Folder" on other platforms and select a directory from the dialog. You can also add more than one directory to your current Atom window, by choosing "File >> Add Project Folder..." from the menu bar or hitting `cmd-shift-O`.

You can open any number of directories from the command line by passing their paths to the `atom` command line tool. For example, you could run the command `atom ./hopes ./dreams` to open both the `hopes` and the `dreams` directories at the same time.

When you open Atom with one or more directories, you will automatically get a Tree view on the side of your window.

![Tree View in an open project](../../images/project-view.png)

The Tree view allows you to explore and modify the file and directory structure of your project. You can open, rename, delete and create new files from this view.

You can also hide and show it with `cmd-\` or the `tree-view:toggle` command from the Palette, and `ctrl-0` will focus it. When the Tree view has focus you can press `a`, `m`, or `delete` to add, move or delete files and folders. You can also simply right-click on a file or folder in the Tree view to see many of the various options, including all of these plus showing the file in your native filesystem or copying the file path to your system clipboard.

{{#note}}

**Atom Packages**

Like many parts of Atom, the Tree view is not built directly into the editor, but is its own standalone package that is simply shipped with Atom by default.

You can find the source code to the Tree View on GitHub at https://github.com/atom/tree-view.

This is one of the interesting things about Atom. Many of its core features are actually just packages implemented the same way you would implement any other functionality. This means that if you don't like the Tree View for example, it's fairly simple to write your own implementation of that functionality and replace it entirely.

{{/note}}

##### Opening a File in a Project

Once you have a project open in Atom, you can easily find and open any file within that project.

If you hit either `cmd-T` or `cmd-P`, the Fuzzy Finder dialog will pop up. This will let you quickly search for any file in any directory your project by typing parts of the path.

![Opening files with the Fuzzy Finder](../../images/finder.png)

You can also search through only the files currently opened (rather than every file in your project) with `cmd-B`. This searches through your "buffers" or open files. You can also limit this fuzzy search with `cmd-shift-B`, which searches only through the files which are new or have been modified since your last Git commit.

The fuzzy finder uses both the `core.ignoredNames` and `fuzzy-finder.ignoredNames` config settings to filter out files and folders that will not be shown. If you have a project with tons of files you don't want it to search through, you can add patterns or paths to either of these config settings. We'll learn more about config settings in [Global Configuration Settings](/using-atom/sections/basic-customization/#_global_configuration_settings), but for now you can easily set these in the Settings view under Core Settings.

Both of those config settings are interpreted as glob patterns as implemented by the [minimatch Node module](https://github.com/isaacs/minimatch).

This package will also not show Git ignored files when the `core.excludeVcsIgnoredPaths` is enabled. You can easily toggle this in the Settings View, it's one of the top options.
