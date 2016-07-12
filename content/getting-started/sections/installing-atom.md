---
title: Installing Atom
---
### Installing Atom

To get started with Atom, we'll need to get it on your system. This section will go over installing Atom on your system as well as the basics of how to build it from source.

Installing Atom should be fairly simple. Generally, you can go to https://atom.io and at the top of the page you should see a download button as shown here:

{{#mac}}

![Download buttons on https://atom.io](../../images/mac-downloads.png "Download buttons on https://atom.io")

{{/mac}}

{{#windows}}

![Download buttons on https://atom.io](../../images/windows-downloads.png "Download buttons on https://atom.io")

{{/windows}}

{{#linux}}

![Download buttons on https://atom.io](../../images/linux-downloads.png "Download buttons on https://atom.io")

{{/linux}}

The button or buttons should be specific to your platform and the download package should be easily installable. However, let's go over them here in a bit of detail.

{{#mac}}

#### Installing Atom on Mac

Atom follows the standard Mac zip installation process. You can either press the download button from the https://atom.io site or you can go to the [Atom releases page][releases] to download the `atom-mac.zip` file explicitly. Once you have that file, you can click on it to extract the application and then drag the new `Atom` application into your "Applications" folder.

When you first open Atom, it will try to install the `atom` and `apm` commands for use in the terminal. In some cases, Atom might not be able to install these commands because it needs an administrator password. To check if Atom was able to install the `atom` command, for example, open a terminal window and type `which atom`. If the `atom` command has been installed, you'll see something like this:

``` command-line
$ which atom
> /usr/local/bin/atom
$
```

If the `atom` command wasn't installed, the `which` command won't return anything:

``` command-line
$ which atom
$
```

To install the `atom` and `apm` commands, run "Window: Install Shell Commands" from the [Command Palette](/getting-started/sections/atom-basics#command-palette), which will prompt you for an administrator password.

{{/mac}}

{{#windows}}

#### Installing Atom on Windows

Atom is available with a Windows installer that can be downloaded from https://atom.io or from [Atom Releases][releases] named `AtomSetup.exe`. This setup program will install Atom, add the `atom` and `apm` commands to your `PATH`, create shortcuts on the desktop and in the start menu, add an "Open with Atom" context menu in the Explorer and make Atom available for association with files using "Open with...".

![Atom on Windows](../../images/windows.gif)

##### Portable mode for Windows

Atom can also be run in portable mode on Windows allowing it to be placed on a removable storage device where it will also store its settings, packages, cache, etc. so you can easily take it from machine to machine without needing to install anything.

To get started with Atom in portable mode:

1. Download `atom-windows.zip` from [Atom Releases][releases]
1. Extract `atom-windows.zip` to your removable storage device
1. Launch atom.exe from the extracted Atom folder
1. Once Atom has launched it will create an `.atom` folder in `%USERPROFILE%`
1. Move that `.atom` folder to be alongside your Atom folder on your removable storage device

Now whenever you launch `atom.exe` from your removable storage device it will operate in portable mode and store all its settings and packages in the `.atom` folder on the device.

Note that there are some limitations to portable mode:

* No Explorer integration or command-line `PATH` setup
* The `.atom` folder must be alongside the folder containing `atom.exe` (not inside it)
* The `.atom` folder must be writeable
* The `ATOM_HOME` environment variable must not be set (this overrides portable behavior)

##### MSI Installer for Windows

Atom is also available in an .MSI package from [Atom Releases](https://github.com/atom/atom/releases/latest) which can be deployed or installed on a machine. Any user signing in to that machine will find Atom installed for them automatically. (It may take a few seconds the first time they sign in for the icon to appear on the desktop).

Should the user uninstall Atom it will only affect themselves and it will not automatically reinstall when they next sign in. If eventually that individual wants to reinstall Atom again, they can delete the `%LOCALAPPDATA%\Atom` folder.

{{/windows}}

{{#linux}}

#### Installing Atom on Linux

To install Atom on Linux, you can download a [Debian package](https://atom.io/download/deb) or [RPM package](https://atom.io/download/rpm) either from the [main Atom website](https://atom.io) or from the [Atom project releases page][releases].

[releases]: https://github.com/atom/atom/releases/latest

On Debian, you would install the Debian package with `dpkg -i`:

``` command-line
$ sudo dpkg -i atom-amd64.deb
```

On RedHat or another RPM based system, you would use the `rpm -i` command:

``` command-line
$ rpm -i atom.x86_64.rpm
```

{{/linux}}

#### Building Atom from Source

If you just want to build Atom from source, you can also do that. The Atom GitHub repository has detailed [build instructions for Mac, Windows, Linux and FreeBSD](https://github.com/atom/atom/tree/master/docs/build-instructions).

#### Proxy and Firewall Settings

##### Behind a firewall?

If you are behind a firewall and seeing SSL errors when installing packages you can disable strict SSL by running:

``` command-line
$ apm config set strict-ssl false
```

##### Using a proxy?

If you are using a HTTP(S) proxy you can configure `apm` to use it by running:

``` command-line
$ apm config set https-proxy <em>YOUR_PROXY_ADDRESS</em>
```

You can run `apm config get https-proxy` to verify it has been set correctly.
