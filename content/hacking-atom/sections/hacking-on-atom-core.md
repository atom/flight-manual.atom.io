---
title: Hacking on Atom Core
---
### Hacking on Atom Core

If you're hitting a bug in Atom or just want to experiment with adding a feature to the core of the system, you'll want to run Atom in Dev Mode with access to a local copy of the Atom source.

#### Fork the atom/atom repository

Follow the [GitHub Help instructions on how to fork a repo](https://help.github.com/articles/fork-a-repo/).

#### Cloning and bootstrapping

Once you've set up your fork of the atom/atom repository, you can clone it to your local machine:

``` command-line
$ git clone git@github.com:<em>your-username</em>/atom.git
```

From there, you can navigate into the directory where you've cloned the Atom source code and run the bootstrap script to install all the required dependencies:

{{#mac}}

``` command-line
$ cd <em>where-you-cloned-atom</em>
$ script/bootstrap
```

{{/mac}}

{{#linux}}

``` command-line
$ cd <em>where-you-cloned-atom</em>
$ script/bootstrap
```

{{/linux}}
 
{{#windows}}

``` command-line
$ cd <em>where-you-cloned-atom</em>
$ script\bootstrap
```

{{/windows}}

#### Running in Development Mode

Once you have a local copy of Atom cloned and bootstrapped, you can then run Atom in Development Mode. But first, if you cloned Atom to somewhere other than <span class="platform-mac platform-linux">`~/github/atom`</span><span class="platform-windows">`%USERPROFILE%\github\atom`</span> you will need to set the `ATOM_DEV_RESOURCE_PATH` environment variable to point to the folder in which you cloned Atom. To run Atom in Dev Mode, use the `--dev` parameter from the terminal:

``` command-line
$ atom --dev <em>path-to-open</em>
```
{{#note}}

**Note:** If the atom command does not respond in the terminal, then try atom-dev or atom-beta. The suffix depends upon the particular source code that was cloned.

{{/note}}

There are a couple benefits of running Atom in Dev Mode:

1. When the `ATOM_DEV_RESOURCE_PATH` environment variable is set correctly, Atom is run using the source code from your local `atom/atom` repository. This means that you don't have to run <span class="platform-mac platform-linux">`script/build`</span><span class="platform-windows">`script\build`</span> every time you change code. Just restart Atom 👍
1. Packages that exist in <span class="platform-mac platform-linux">`~/.atom/dev/packages`</span><span class="platform-windows">`%USERPROFILE%\.atom\dev\packages`</span> are loaded instead of packages of the same name normally loaded from other locations. This means that you can have development versions of packages you use loaded but easily go back to the stable versions by launching without Dev Mode.
1. Packages that contain stylesheets, such as syntax themes, will have those stylesheets automatically reloaded by the [dev-live-reload](https://github.com/atom/dev-live-reload) package. This does not live reload JavaScript or CoffeeScript files — you'll need to reload the window (`window:reload`) to see changes to those.

#### Running Atom Core Tests Locally

In order to run Atom Core tests from the terminal, first be certain to set the `ATOM_DEV_RESOURCE_PATH` environment variable as mentioned above and then:

``` command-line
$ cd <em>path-to-your-local-atom-repo</em>
$ atom --test spec
```

#### Building

In order to build Atom from source, you need to have a number of other requirements and take additional steps.

{{#mac}}

##### Requirements

* macOS 10.9 or later
* Node.js 6.x or later (we recommend installing it via [nvm](https://github.com/creationix/nvm))
* npm 3.10.x or later (run `npm install -g npm`)
* Python v2.7.x
* Command Line Tools for [Xcode](https://developer.apple.com/xcode/downloads/) (run `xcode-select --install` to install)

{{/mac}}

{{#windows}}

* Node.js 6.9.4 or later (the architecture of node available to the build system will determine whether you build 32-bit or 64-bit Atom)
* Python v2.7.x
  * The `python.exe` must be available at `%SystemDrive%\Python27\python.exe`. If it is installed elsewhere create a symbolic link to the directory containing the `python.exe` using: `mklink /d %SystemDrive%\Python27 D:\elsewhere\Python27`
* 7zip (7z.exe available from the command line) - for creating distribution zip files
* C++ build tools, either:
  * [Visual C++ Build Tools 2015](https://visualstudio.microsoft.com/vs/older-downloads/)
  * [Visual Studio 2013 Update 5](https://www.visualstudio.com/downloads/) (Express Edition or better)
  * [Visual Studio 2015](https://www.visualstudio.com/downloads/) (Community Edition or better)
  * **Unsupported** but more convenient for some who know Node: [windows-build-tools](https://www.npmjs.com/package/windows-build-tools)


  Also ensure that:

  * The default installation folder is chosen so the build tools can find it
  * If using Visual Studio make sure Visual C++ support is selected/installed
  * If using Visual C++ Build Tools make sure Windows 8 SDK is selected/installed
  * A `git` command is in your path
  * Set the `GYP_MSVS_VERSION` environment variable to the Visual Studio/Build Tools version (`2013` or `2015`) e.g. ``[Environment]::SetEnvironmentVariable("GYP_MSVS_VERSION", "2015", "User")`` in PowerShell (or set it in Windows advanced system settings).

{{/windows}}

{{#linux}}

Ubuntu LTS 16.04 64-bit is the recommended platform.

##### Requirements

* OS with 64-bit or 32-bit architecture
* C++11 toolchain
* Git
* Node.js 6.x or later (we recommend installing it via [nvm](https://github.com/creationix/nvm))
* npm 3.10.x or later (run `npm install -g npm`)
* Ensure node-gyp uses python2 (run `npm config set python /usr/bin/python2 -g`, use `sudo` if you didn't install node via nvm)
* Development headers for [libsecret](https://wiki.gnome.org/Projects/Libsecret).

For more details, scroll down to find how to setup a specific Linux distro.

###### Ubuntu / Debian

* Install GNOME headers and other basic prerequisites:

  ``` command-line
  $ sudo apt-get install build-essential git libsecret-1-dev fakeroot rpm libx11-dev libxkbfile-dev
  ```

* If `script/build` exits with an error, you may need to install a newer C++ compiler with C++11:

  ``` command-line
  $ sudo add-apt-repository ppa:ubuntu-toolchain-r/test
  $ sudo apt-get update
  $ sudo apt-get install gcc-5 g++-5
  $ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 80 --slave /usr/bin/g++ g++ /usr/bin/g++-5
  $ sudo update-alternatives --config gcc # choose gcc-5 from the list
  ```

###### Fedora 22+

``` command-line
$ sudo dnf --assumeyes install make gcc gcc-c++ glibc-devel git-core libsecret-devel rpmdevtools libX11-devel libxkbfile-devel
```

###### Fedora 21 / CentOS / RHEL

``` command-line
$ sudo yum install -y make gcc gcc-c++ glibc-devel git-core libsecret-devel rpmdevtools
```

###### Arch

``` command-line
sudo pacman -S --needed gconf base-devel git nodejs npm libsecret python2 libx11 libxkbfile
```

Be certain to use `export PYTHON=/usr/bin/python2` before building Atom.

###### Slackware

``` command-line
$ sbopkg -k -i node -i atom
```

###### openSUSE

``` command-line
$ sudo zypper install nodejs nodejs-devel make gcc gcc-c++ glibc-devel git-core libsecret-devel rpmdevtools libX11-devel libxkbfile-devel
```

{{/linux}}

##### Instructions

{{#mac}}

``` command-line
$ script/build
```

To also install the newly built application, use `script/build --install`.

{{/mac}}

{{#windows}}

``` command-line
$ script\build
```

To also install the newly built application, use `script\build --create-windows-installer` and launch one of the generated installers.

{{/windows}}

{{#linux}}

``` command-line
$ script/build
```

To also install the newly built application, use the `--create-debian-package` or `--create-rpm-package` option and then install the generated package via the system package manager.

{{/linux}}

{{#mac}}

##### `script/build` Options

* `--code-sign`: signs the application with the GitHub certificate specified in `$ATOM_MAC_CODE_SIGNING_CERT_DOWNLOAD_URL`.
* `--compress-artifacts`: zips the generated application as `out/atom-mac.zip`.
* `--install[=dir]`: installs the application at `${dir}/Atom.app` for dev and stable versions or at `${dir}/Atom-Beta.app` for beta versions; `${dir}` defaults to `/Applications`.

{{/mac}}

{{#windows}}

##### `script\build` Options

* `--code-sign`: signs the application with the GitHub certificate specified in `$WIN_P12KEY_URL`.
* `--compress-artifacts`: zips the generated application as `out\atom-windows.zip` (requires [7-Zip](http://www.7-zip.org)).
* `--create-windows-installer`: creates an `.exe` and two `.nupkg` packages in the `out` directory.
* `--install[=dir]`: installs the application in `${dir}\Atom\app-dev`; `${dir}` defaults to `%LOCALAPPDATA%`.

{{/windows}}

{{#linux}}

##### `script/build` Options

* `--compress-artifacts`: zips the generated application as `out/atom-{arch}.tar.gz`.
* `--create-debian-package`: creates a .deb package as `out/atom-{arch}.deb`
* `--create-rpm-package`: creates a .rpm package as `out/atom-{arch}.rpm`
* `--install[=dir]`: installs the application in `${dir}`; `${dir}` defaults to `/usr/local`.

{{/linux}}

##### Troubleshooting

{{#mac}}

Use [this search](https://github.com/atom/atom/search?q=label%3Abuild-error+label%3Amac&type=Issues) to get a list of reports about build errors on macOS.

{{/mac}}

{{#windows}}

###### Common Errors

* `node is not recognized`
  * If you just installed Node.js, you'll need to restart Command Prompt before the `node` command is available on your path.

* `msbuild.exe failed with exit code: 1`
   * If using **Visual Studio**, ensure you have the **Visual C++** component installed. Go into Add/Remove Programs, select Visual Studio, press Modify, and then check the Visual C++ box.
   * If using **Visual C++ Build Tools**, ensure you have the **Windows 8 SDK** component installed. Go into Add/Remove Programs, select Visual C++ Build Tools, press Modify and then check the Windows 8 SDK box.

* `script\build` stops with no error or warning shortly after displaying the versions of node, npm and Python
  * Make sure that the path where you have checked out Atom does not include a space. For example, use `C:\atom` instead of `C:\my stuff\atom`.
  * Try moving the repository to `C:\atom`. Most likely, the path is too long. See [issue #2200](https://github.com/atom/atom/issues/2200).

* `error MSB4025: The project file could not be loaded. Invalid character in the given encoding.`
  * This can occur because your home directory (`%USERPROFILE%`) has non-ASCII characters in it. This is a bug in [gyp](https://code.google.com/p/gyp/)
    which is used to build native Node.js modules and there is no known workaround.
    * https://github.com/TooTallNate/node-gyp/issues/297
    * https://code.google.com/p/gyp/issues/detail?id=393

* `'node_modules\.bin\npm' is not recognized as an internal or external command, operable program or batch file.`
   * This occurs if the previous build left things in a bad state. Run `script\clean` and then `script\build` again.

* `script\build` stops at installing runas with `Failed at the runas@x.y.z install script.`
  * See the next item.

* `error MSB8020: The build tools for Visual Studio 201? (Platform Toolset = 'v1?0') cannot be found.`
  * Try setting the `GYP_MSVS_VERSION` environment variable to **2013** or **2015** depending on what version of Visual Studio/Build Tools is installed and then `script\clean` followed by `script\build` (re-open the Command Prompt if you set the variable using the GUI).

* `'node-gyp' is not recognized as an internal or external command, operable program or batch file.`
  * Try running `npm install -g node-gyp`, and run `script\build` again.

* Other `node-gyp` errors on first build attempt, even though the right Node.js and Python versions are installed.
  * Do try the build command one more time as experience shows it often works on second try in many cases.

###### Windows build error reports

* If all else fails, use [this search](https://github.com/atom/atom/search?q=label%3Abuild-error+label%3Awindows&type=Issues) to get a list of reports about build errors on Windows, and see if yours has already been reported.
* If it hasn't, please open a new issue with your Windows version, architecture (x86 or x64), and a text dump of your build output, including the Node.js and Python versions.

{{/windows}}

{{#linux}}

###### TypeError: Unable to watch path

If you get following error with a big traceback right after Atom starts:

```
TypeError: Unable to watch path
```

you have to increase number of watched files by inotify.  For testing if this is the reason for this error you can execute:

``` command-line
$ sudo sysctl fs.inotify.max_user_watches=32768
```

then restart Atom.  If Atom now works fine, you can make this setting permanent:

``` command-line
$ echo 32768 | sudo tee -a /proc/sys/fs/inotify/max_user_watches
```

See also [#2082](https://github.com/atom/atom/issues/2082).

###### /usr/bin/env: node: No such file or directory

If you get this notice when attempting to run any script, you either do not have
Node.js installed, or node isn't identified as Node.js on your machine. If it's
the latter, this might be caused by installing Node.js via the distro package
manager and not nvm, so entering `sudo ln -s /usr/bin/nodejs /usr/bin/node` into
your terminal may fix the issue. On some variants (mostly Debian based distros)
you can use `update-alternatives` too:

``` command-line
$ sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 1 --slave /usr/bin/js js /usr/bin/nodejs
```

###### AttributeError: 'module' object has no attribute 'script_main'

If you get following error with a big traceback while building Atom:

```
sys.exit(gyp.script_main()) AttributeError: 'module' object has no attribute 'script_main' gyp ERR!
```

you need to uninstall the system version of gyp.

On Fedora you would do the following:

``` command-line
$ sudo yum remove gyp
```

###### Linux build error reports

Use [this search](https://github.com/atom/atom/search?q=label%3Abuild-error+label%3Alinux&type=Issues)
to get a list of reports about build errors on Linux.

{{/linux}}
