---
title: Version Control in Atom
---
### Version Control in Atom

Version control is an important aspect of any project and Atom comes with basic [Git](https://git-scm.com) and [GitHub](https://github.com) integration built in.

In order to use version control in Atom, the project root needs to contain the Git repository.

#### Checkout HEAD revision

The <kbd class="platform-mac">Alt+Cmd+Z</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+Z</kbd> keybinding checks out the `HEAD` revision of the file in the editor.

This is a quick way to discard any saved and staged changes you've made and restore the file to the version in the `HEAD` commit. This is essentially the same as running `git checkout HEAD -- <path>` and `git reset HEAD -- <path>` from the command line for that path.

![Git checkout `HEAD`](../../images/git-checkout-head.gif "Git checkout `HEAD`")

This command goes onto the undo stack so you can use <kbd class="platform-mac">Cmd+Z</kbd><kbd class="platform-windows platform-linux">Ctrl+Z</kbd> afterwards to restore the previous contents.

#### Git status list

Atom ships with the [fuzzy-finder package](https://github.com/atom/fuzzy-finder) which provides <kbd class="platform-mac">Cmd+T</kbd><kbd class="platform-windows platform-linux">Ctrl+T</kbd> to quickly open files in the project and <kbd class="platform-mac">Cmd+B</kbd><kbd class="platform-windows platform-linux">Ctrl+B</kbd> to jump to any open editor. The package also provides <kbd class="platform-mac">Cmd+Shift+B</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+B</kbd> which displays a list of all the untracked and modified files in the project. These will be the same files that you would see on the command line if you ran `git status`.

![Git status list](../../images/git-status.gif "`git status` list")

An icon will appear to the right of each file letting you know whether it is untracked or modified.

#### Commit editor

Atom can be used as your Git commit editor and ships with the [language-git package](https://github.com/atom/language-git) which adds syntax highlighting to edited commit, merge, and rebase messages.

![Git commit message highlighting](../../images/git-message.gif "Git commit message highlighting")

You can configure Atom to be your Git commit editor with the following command:

``` command-line
$ git config --global core.editor "atom --wait"
```

The [language-git](https://github.com/atom/language-git) package will help remind you to be brief by colorizing the first lines of commit messages when they're longer than 50 or 65 characters.

#### Status bar icons

The [status-bar](https://github.com/atom/status-bar) package that ships with Atom includes several Git decorations that display on the right side of the status bar:

![Git Status Bar decorations](../../images/git-status-bar.png "Git Status Bar decorations")

The currently checked out branch name is shown with the number of commits the branch is ahead of or behind its upstream branch. An icon is added if the file is untracked, modified, or ignored. The number of lines added and removed since the file was last committed will be displayed as well.

#### Line diffs

The included [git-diff](https://github.com/atom/git-diff) package colorizes the gutter next to lines that have been added, edited, or removed.

![Git line diff indications](../../images/git-lines.png "Git line diff indications")

This package also adds <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">Down</kbd> and <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">Up</kbd> keybindings that allow you to move the cursor to the next or previous diff in the current editor.

#### Open on GitHub

If the project you're working on is on GitHub, there are also some very useful integrations you can use.  Most of the commands will take the current file you're viewing and open a view of that file on GitHub - for instance, the blame or commit history of that file.

* <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">O</kbd> - Open file on GitHub
* <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">B</kbd> - Open Blame view of file on GitHub
* <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">H</kbd> - Open History view of file on GitHub
* <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">C</kbd> - Copy the URL of the current file on GitHub to the clipboard
* <kbd class="platform-all">Alt+G</kbd> <kbd class="platform-all">R</kbd> - Branch compare on GitHub

The branch comparison shows you the commits that are on the branch you're currently working on locally that are not on the mainline branch.

![Open Blame of file on GitHub](../../images/open-on-github.png "Open Blame of file on GitHub")
