---
title: Version Control in Atom
---
### Version Control in Atom

Version control is an important aspect of any project and Atom comes with basic [Git](http://git-scm.com) and [GitHub](https://github.com) integration baked in.

#### Checkout HEAD revision

The `cmd-alt-Z` keybinding checks out the HEAD revision of the file in the editor.

This is a quick way to discard any saved and staged changes you've made and restore the file to the version in the HEAD commit. This is essentially the same as running `git checkout HEAD -- <path>` and `git reset HEAD -- <path>` from the command line for that path.

![Git checkout HEAD](../../images/git-checkout-head.gif)

This command goes onto the undo stack so you can use `cmd-Z` afterwards to restore the previous contents.

#### Git status list

Atom ships with the fuzzy-finder package which provides `cmd-T` to quickly open files in the project and `cmd-B` to jump to any open editor.

The package also comes with `cmd-shift-B` which pops up a list of all the untracked and modified files in the project. These will be the same files that you would see on the command line if you ran git status.

![Git status list](../../images/git-status.gif)

An octicon will appear to the right of each file letting you know whether it is untracked or modified.

#### Commit editor

Atom can be used as your Git commit editor and ships with the language-git package which adds syntax highlighting to edited commit, merge, and rebase messages.

![Git commit message highlighting](../../images/git-message.gif)

You can configure Atom to be your Git commit editor with the following command:

``` command-line
$ git config --global core.editor "atom --wait"
```

The [language-git](https://github.com/atom/language-git) package will help you with your brevity by colorizing the first lines of commit messages when they're longer than 50 and 65 characters.

#### Status bar icons

The [status-bar](https://github.com/atom/language-git) package that ships with Atom includes several Git decorations that display on the right side of the status bar.

![Git Status Bar](../../images/git-status-bar.png)

The currently checked out branch name is shown with the number of commits the branch is ahead of or behind its upstream branch.

An icon is added if the file is untracked, modified, or ignored. The number of lines added and removed since the file was last committed will be displayed as well.

#### Line diffs

The included [git-diff](https://github.com/atom/git-diff) package colorizes the gutter next to lines that have been added, edited, or removed.

![Git line diffs](../../images/git-lines.png)

This package also adds `alt-g down` and `alt-g up` keybindings that allow you to move the cursor to the next/previous diff hunk in the current editor.

#### Open on GitHub

If the project you're working on is on GitHub, there are also some very useful integrations you can use.  Most of the commands will take the current file you're viewing and open a view of that file on GitHub - for instance, the blame or commit history of that file.

`alt-G O`:: Open file on GitHub

`alt-G B`:: Open blame of file on GitHub

`alt-G H`:: Open history of file on GitHub

`alt-G C`:: Copy the URL of the current file on GitHub

`alt-G R`:: Branch compare on GitHub

The branch comparison simply shows you the commits that are on the branch you're currently working on locally that are not on the mainline branch.

![Open Blame of file on GitHub](../../images/open-on-github.png)
