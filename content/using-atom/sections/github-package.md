---
title: GitHub package
---
### GitHub package

The github package brings Git and GitHub integration right inside Atom.

- [Initialize](#initialize-repositories)
- [Clone](#clone-repositories)
- [Branch](#branch)
- [Stage](#stage)
- [Discard](#discard-changes)
- [Commit](#commit)
- [Amend](#amend-previous-commit)
- [Push](#push)
- [Pull](#pull)
- [Resolve conflicts](#resolve-conflicts)
- [View Pull Requests](#view-pull-requests)

Most of the functionality lives in the Git and GitHub panel. There are different ways to access them, probably the most common way is through their keybindings:

- Open the **Git** panel: <kbd class=".platform-all">Ctrl+9</kbd>
- Open the **GitHub** panel: <kbd class=".platform-all">Ctrl+8</kbd>

Or you can also toggle the Git panel from the Status Bar by clicking on the changed files icon:

![Open Git panel](../../images/github-open-git-panel.png "Open Git panel")


---

#### Initialize repositories

In case a project doesn't have a Git repository yet, you can create one from the Git panel.

![Initialize repositories](../../images/github-initialize.png "Initialize repositories")


#### Clone repositories

To clone a repository, run the `GitHub: Clone` command. In the dialog paste a URL of a repository and click "Clone". A new project will get added to the Tree View.

![Clone repositories](../../images/github-clone.png "Clone repositories")


#### Branch

To open the branch tooltip, click the branch icon in the Status Bar. From there you can to **create** or **switch** branches.

![Create or switch branches](../../images/github-branch.png "Create or switch branches")


#### Stage

After making some changes, **stage** anything you want to be part of the next commit. Choose between staging...

- **All changes**: Click the "Stage All" button in the "Unstaged Changes" bar.
- **Files**: Double-click a file or select a file and press <kbd class=".platform-all">Enter</kbd>.
- **Hunk**: Click on the "Stage Hunk" button or select a hunk and press <kbd class=".platform-all">Enter</kbd>.
- **Lines**: Click on a line (or drag on multiple lines) to select, then click on the "Stage Selection" button. Or use the <kbd class=".platform-all">/</kbd> key to toggle from hunk mode to line mode, then press <kbd class=".platform-all">Enter</kbd> to stage just a single line.

Use the <kbd class=".platform-all">Left</kbd> or <kbd class=".platform-all">Right</kbd> arrow key to switch between file list and the diff view. Unstaging can be done in the same way.

![Stage changes](../../images/github-stage.png "Stage changes")


#### Discard changes

If you no longer want to keep some changes, you can discard them. It's similar to staging, but accessible behind a context menu.

- **All changes**: Right-click the "Unstaged Changes" bar and choose "Discard All Changes".
- **Files**: Right-click a file (or multiple) and choose "Discard Changes".
- **Hunk**: Click on the trash icon in the top bar of a hunk.
- **Lines**: Right-click on a line (or multiple) and choose "Discard Selection".

![Discard changes](../../images/github-discard.png "Discard changes")


#### Commit

Once you've staged your changes, enter a commit **message**. Feel free to describe the commit in more detail after leaving an empty line. Finalize by clicking the **Commit** button.

![Commit changes](../../images/github-commit.png "Commit changes")

If you need more space, click the expand icon at the bottom right. It will open a commit editor in the center.


#### Amend previous commit

In case you forgot to commit a change and would like to add it to your previous commit, clicking the "Amend" checkbox. Now you can stage more changes or adjust the commit message.

![Amend previous commit](../../images/github-amend.png "Amend previous commit")


#### Push

When you're ready to share your changes with your team members, click the **Push** button in the Status Bar tooltip. If your local branch doesn't exist on the remote repository, Atom will offer to create a remote branch for you.

![Push commits](../../images/github-push.png "Push commits")


#### Pull

Click on the **Fetch** button to see if anyone made changes. **Pull** to get the changes into your local branch.

![Pull commits](../../images/github-pull.png "Pull commits")


#### Resolve conflicts

Sometimes there can be conflicts when trying to merge. Files that have merge conflicts will show up in the "Merge Conflicts" list. Click on a file to open the editor. There you can **resolve** the conflict by picking a version or make further edits. Once done, stage the file and commit.

![Resolve conflicts](../../images/github-resolve-conflicts.png "Resolve conflicts")


#### View Pull Requests

If there is a **Pull Request** for your current branch, you can see its status in the "GitHub" panel. Click on **Conversation** to see the timeline.

![View Pull Requests](../../images/github-view-pull-requests.png "View Pull Requests")
