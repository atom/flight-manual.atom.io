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
- [Undo discard](#undo-discard)
- [Commit](#commit)
- [Amend and undo](#amend-and-undo)
- [Publish and push](#publish-and-push)
- [Fetch and pull](#fetch-and-pull)
- [Resolve conflicts](#resolve-conflicts)
- [Create a Pull Request](#create-a-pull-request)
- [View Pull Requests](#view-pull-requests)
- [Checkout a Pull Request](#checkout-a-pull-request)
- [Open any Issue or Pull Request](#open-any-issue-or-pull-request)

Most of the functionality lives within the Git and GitHub dock items.

![The Git and GitHub panels](../../images/github-panels.png "The Git and GitHub panels")

There are different ways to access them, probably the most common way is through their keybindings:

- Open the **Git** panel: <kbd class=".platform-all">Ctrl+9</kbd>
- Open the **GitHub** panel: <kbd class=".platform-all">Ctrl+8</kbd>

Another way is from the menu: `Packages -> GitHub -> Toggle Git Tab and Toggle GitHub Tab`

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

- **All changes**: Click the <kbd>...</kbd> menu in the "Unstaged Changes" header and choose "Discard All Changes".
- **Files**: Right-click a file (or multiple) and choose "Discard Changes".
- **Hunk**: Click on the trash icon in the top bar of a hunk.
- **Lines**: Right-click on a line (or multiple) and choose "Discard Selection".

![Discard changes](../../images/github-discard.png "Discard changes")


#### Undo discard

If you want cancel discarding some changes, you can restore them.

Click the <kbd>...</kbd> menu in the "Unstaged Changes" header and choose "Undo Last Discard".  
If there are any conflicts when undoing the last discard, you will be notified that "Undoing will result in conflicts".

- **Merge with conflict markers**: The discarded changes are merged back into their original file.  
The conflict resolution works similarly to cherry-picking, where "their" changes are the ones you previously discarded.
- **Open in new file**: The discarded changed are merged with the existing contents into a new temporary file.
- **Cancel**: The "Undo Last Discard" action is cancelled.

![Handle conflicts with undo discard](../../images/github-undo-discard-conflicts.png "Handle conflicts with undo discard")


#### Commit

Once you've staged your changes, enter a commit **message**. Feel free to describe the commit in more detail after leaving an empty line. Finalize by clicking the **Commit** button. If you need more space, click the expand icon at the bottom right. It will open a commit editor in the center.

![Commit changes](../../images/github-commit.png "Commit changes")

To add multiple **co-authors** to a commit, click the "👤➕" icon in the bottom left corner of the commit message editor. Now you can search by name, email or GitHub username to give credit to a co-author.

![Commit with co-authors](../../images/github-commit-with-co-authors.png "Commit with co-authors")


#### Amend and undo

In case you forgot to commit a change and would like to add it to your previous commit, right-click on the last commit, then choose "Amend" from the context menu.

![Amend previous commit](../../images/github-amend.png "Amend previous commit")

If you want to edit the commit message of your last commit, or add/remove changes, click on the "Undo" button. It will roll back to the state just before you clicked on the commit button.

![Undo previous commit](../../images/github-undo.png "Undo previous commit")


#### Publish and push

When you're ready to share your changes with your team members, click the **Publish** button in the Status Bar. It will push your local branch to the remote repository. After making more commits, you can **Push** them as well from the Status Bar.

![Publish and push commits](../../images/github-publish-push.png "Publish and push commits")


#### Fetch and pull

From time to time it's a good idea to click on the **Fetch** button to see if any other team member pushed changes. If so, click on **Pull** to merge the changes into your local branch.

![Fetch and pull commits](../../images/github-fetch-pull.png "Fetch and pull commits")

If you prefer to **rebase** when pulling, you can configure Git to make it the default behavior:

```
git config --global --bool pull.rebase true
```

Learn more about [merge vs. rebase](https://mislav.net/2013/02/merge-vs-rebase/).

#### Resolve conflicts

Sometimes there can be conflicts when trying to merge. Files that have merge conflicts will show up in the "Merge Conflicts" list. Click on a file to open the editor. There you can **resolve** the conflict by picking a version or make further edits. Once done, stage the file and commit.

![Resolve conflicts](../../images/github-resolve-conflicts.png "Resolve conflicts")


#### Create a Pull Request

When your changes are ready to be reviewed by your team members, open the "GitHub" panel <kbd>Ctrl+8</kbd> and click on **Open new pull request**. It will open the browser where you can continue creating a pull request. If commits haven't been pushed or the branch isn't published yet, the GitHub package will do that automatically for you.

![Create a Pull Request](../../images/github-create-a-pull-request.png "Create a Pull Request")


#### View Pull Requests

Once the pull request is created, it will appear under **Current pull request** at the top of the panel. Underneath is a list of **Open pull requests**. It lets you quickly find a pull request by avatar, title or PR number. It also lets you keep an eye on the CI status. Clicking on a pull request in the list opens a center pane with more details, the timeline and conversations.

![View Pull Requests](../../images/github-view-pull-requests.png "View Pull Requests")


#### Open any Issue or Pull Request

You can open issues or pull requests from any repo on GitHub. To do so, run the `GitHub: Open Issue Or Pull Request` command and paste the URL from an issue or pull request. Then press the **Open Issue or Pull Request** button and it will open a center pane. This lets you keep an issue or pull request as a reference, when working in another repo.

![Open Issue or Pull Request](../../images/github-open-issue-or-pull-request.png "Open Issue or Pull Request")


#### Checkout a Pull Request

To test a pull request locally, open it in the workspace center by clicking on the pull request in the "open pull requests" list from the GitHub tab, then click on the **Checkout** button. It will automatically create a local branch and pull all the changes. If you would like to contribute to that pull request, start making changes, commit and push. Your contribution is now part of that pull request.

![Checkout a pull request](../../images/github-checkout.png "Checkout a pull request")
