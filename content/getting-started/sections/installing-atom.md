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

##### MSI Installer for Windows

Atom is also available in an .MSI package from [Atom Releases](https://github.com/atom/atom/releases/latest) which can be deployed or installed on a machine. Any user signing in to that machine will find Atom installed for them automatically. (It may take a few seconds the first time they sign in for the icon to appear on the desktop).

Should the user uninstall Atom it will only affect themselves and it will not automatically reinstall when they next sign in. If eventually that individual wants to reinstall Atom again, they can delete the `%LOCALAPPDATA%\Atom` folder.

{{/windows}}

{{#linux}}

#### Installing Atom on Linux

To install Atom on Linux, you can download a [Debian package](https://atom.io/download/deb) or [RPM package](https://atom.io/download/rpm) either from the [main Atom website](https://atom.io) or from the [Atom project releases page][releases]. These packages do not currently have auto-update features, so when you would like to upgrade to a new release of Atom, you will have to repeat this installation process.

[releases]: https://github.com/atom/atom/releases/latest

##### Debian and Ubuntu (deb/apt)

To install Atom on Debian, Ubuntu, or related systems:

``` command-line
# Install Atom
$ sudo dpkg -i atom-amd64.deb

# Install Atom's dependencies if they are missing
$ sudo apt-get -f install
```

##### RedHat and CentOS (yum)

To install Atom on CentOS, Oracle Linux, RedHat Enterprise Linux, Scientific Linux or related systems that use the yum package manager:

``` command-line
$ sudo yum install -y atom.x86_64.rpm
```

##### Fedora (dnf)

To install the latest release of Atom on Fedora or other systems that use the DNF package manager:

``` command-line
$ sudo dnf install -y atom.x86_64.rpm
```

##### SUSE (zypp)

To install the latest release of Atom on openSUSE or other systems that use the Zypp package manager:

``` command-line
$ sudo zypper in -y atom.x86_64.rpm
```

{{/linux}}


#### Portable Mode

Atom stores configuration and state in a `.atom` directory usually located in your home directory <span class="platform-windows">(`%userprofile%` on Windows)</span>. You can however run Atom in portable mode where both the app and the configuration are stored together such as on a removable storage device.

To setup Atom in portable mode download the [zip/tar.gz package for your system](https://github.com/atom/atom/releases/latest) and extract it to your removable storage.

{{#windows}}

Then create a `.atom` directory alongside the directory that contains atom.exe, for example:

```
e:\atom-1.14\atom.exe
e:\.atom
```

{{/windows}}

{{#mac}}

Then create a `.atom` directory alongside the Atom.app application, for example:

```
/MyUSB/Atom.app
/MyUSB/.atom
```

{{/mac}}

{{#linux}}

Then create a `.atom` directory alongside the directory that contains the Atom binary, for example:

```
/media/myusb/atom-1.14/atom
/media/myusb/.atom
```

{{/linux}}

##### Portable Notes

- The `.atom` directory must be writeable
- You can move an existing `.atom` directory to your portable device
- Atom can also store its Electron user data in your `.atom` directory - just create a subdirectory called `electronUserData` inside `.atom`
- Alternatively you can set the `ATOM_HOME` environment variable to point wherever you want (you can write a .sh or .cmd script to temporarily set it and launch it from that)

#### Building Atom from Source

If you just want to build Atom from source, you can also do that. The Atom GitHub repository has detailed [build instructions for Mac, Windows, Linux and FreeBSD](https://github.com/atom/atom/tree/master/docs/build-instructions).

#### Proxy and Firewall Settings

##### Behind a Firewall?

If you are behind a firewall and seeing SSL errors when installing packages you can disable strict SSL by running:

``` command-line
$ apm config set strict-ssl false
```

##### Using a Proxy?

If you are using a HTTP(S) proxy you can configure `apm` to use it by running:

``` command-line
$ apm config set https-proxy <em>YOUR_PROXY_ADDRESS</em>
```

You can run `apm config get https-proxy` to verify it has been set correctly.
