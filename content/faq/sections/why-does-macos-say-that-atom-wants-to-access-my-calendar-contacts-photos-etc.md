---
title: Why does macOS say that Atom wants to access my calendar, contacts, photos, etc.?
---
### Why does macOS say that Atom wants to access my calendar, contacts, photos, etc.?

With macOS 10.14 Mojave, Apple introduced new privacy protections similar to the existing protections found in iOS. Whenever an application attempts to access the files inside certain newly-protected directories, macOS asks the user whether they want to allow the application to access the content in those directories. These new privacy protections apply to the directories that contain your calendars, contacts, photos, mail, messages, and Time Machine backups.

Applications trigger these new macOS prompts when attempting to access these directories in any way. Simply attempting to *list* the files in one of these directories is enough to trigger these prompts. These protections even apply to Apple's own applications. For example, if you open `Terminal.app` and try to list the files in `~/Library/Calendars`, macOS shows a prompt saying, '"Terminal" would like access to your calendar.'

<img width="602" alt="screen shot 2018-10-03 at 14 04 40 pm" src="https://user-images.githubusercontent.com/2988/46432184-9bfe9f80-c71b-11e8-8916-e844b7f4110e.png">

#### Why does Atom need access to my calendar, contacts, photos, etc.?

Atom doesn't need access to these items, but you might unintentionally cause Atom to try to access these items. This commonly occurs when you open your home directory (`~`) inside Atom and run a command that examines all files and directories beneath your home directory. For example, when you open the [fuzzy-finder](https://flight-manual.atom.io/getting-started/sections/atom-basics/#opening-a-file-in-a-project), it indexes the currently-open directory so that it can show you the available files:

<img width="1030" alt="fuzzy-finder can trigger prompt" src="https://user-images.githubusercontent.com/2988/46432185-9bfe9f80-c71b-11e8-83f7-758c3212d16c.png">

Similarly, using [find-and-replace](https://flight-manual.atom.io/using-atom/sections/find-and-replace/) across the entire home directory will cause Atom to scan all files under your home directory.

In addition to containing the files you're *intending* to edit inside Atom, your home directory also contains your files that have new OS-level protections in Mojave:

- Calendar files (`~/Library/Calendars`)
- Contacts files (`~/Library/Application\ Support/AddressBook`
- Mail files (`~/Library/Mail`)
- Photos files (`~/Pictures/Photos\ Library.photoslibrary`)

Before letting Atom read these files, Mojave is understandably asking whether you want Atom to be able to access this personal data.

#### What should I do when I see these prompts?

Most people don't use Atom to view or edit their calendar files, contact files, photo library, etc. If you don't intend to use Atom to view/edit these files, then Atom doesn't need access to them. If you see a prompt from macOS saying that Atom would like to access these items, simply click **Don't Allow**.

#### What happens if I *allow* Atom to access my calendar, contacts, photos, etc.?

To Atom, these items are just files on disk. Atom treats them exactly like any other file you would view in Atom. Therefore, if you allow Atom to access these items, you'll be able to use Atom to browse the directories that contain these items, and you'll be able to view the files in those directories. That's it. Nothing more.

#### You'll only be prompted once

Fortunately, macOS will only prompt you once for each type of personal data. In other words, you might see a prompt asking you whether Atom can access your calendar, and you might see a prompt asking you whether Atom can access your contacts, but once you make those decisions, you won't see those prompts again.

#### What if I change my mind?

At any time, you can change your choices via System Preferences. Inside System Preferences, go to `Security and Privacy`, click the `Privacy` tab, and then click on `Calendars` to manage which apps can access your `Calendars`. The same goes for `Contacts`, `Photos`, etc.:

<img width="780" alt="manage access in system preferences" src="https://user-images.githubusercontent.com/2988/46432459-51315780-c71c-11e8-96b5-83edea8b4be2.png">

#### What if I never want to see these prompts?

Many people understandably expect their text editor to be able to open any file on disk. And that's exactly how things worked prior to macOS Mojave. If you would like to restore that behavior, you can proactively instruct macOS to allow you to access all files with Atom. To do so:

1. Open your `Applications` folder in the Finder
2. Open System Preferences, click the `Security and Privacy` icon, click the `Privacy` tab, and then click on `Full Disk Access` in the left-hand sidebar
3. Click the lock icon to unlock System Preferences
4. Drag Atom into `Full Disk Access` as shown below

![restore pre-mojave security via full-disk access](https://user-images.githubusercontent.com/2988/46491820-cf9fff00-c7d9-11e8-8b92-44fea5d3c437.gif)
