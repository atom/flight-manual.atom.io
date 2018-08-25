---
title: Debugging
---
### Debugging

Atom provides several tools to help you understand unexpected behavior and debug problems. This guide describes some of those tools and a few approaches to help you debug and provide more helpful information when [submitting issues](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#submitting-issues):

#### Update to the Latest Version

You might be running into an issue which was already fixed in a more recent version of Atom than the one you're using.

If you're using a released version, check which version of Atom you're using:

``` command-line
$ atom --version
> Atom    : 1.8.0
> Electron: 0.36.8
> Chrome  : 47.0.2526.110
> Node    : 5.1.1
```

Then check for the [latest Stable version](https://github.com/atom/atom/releases/latest).

{{#mac}}

If there is a more recent release available, you can update to the most recent release with the auto-update functionality built in to Atom and the [about package](https://github.com/atom/about). You can open the About View by using the _Atom > About_ menu option to see whether Atom is up-to-date, downloading a new update or click the button to "Restart and Install Update".

{{/mac}}

{{#windows}}

If there is a more recent release available, you can update to the most recent release with the auto-update functionality built in to Atom and the [about package](https://github.com/atom/about). You can open the About View by using the _Help > About_ menu option to see whether Atom is up-to-date, downloading a new update or click the button to "Restart and Install Update".

{{/windows}}

{{#linux}}

To update to the latest version, you can download it from [the atom.io website](https://atom.io) or [the latest release on GitHub](https://github.com/atom/atom/releases/latest) and follow the [Installation instructions for Atom on Linux](/getting-started/sections/installing-atom/#installing-atom-on-linux).

{{/linux}}

If you're building Atom from source, pull down the latest version of master and [re-build](https://github.com/atom/atom#building).

#### Using Safe Mode

A large part of Atom's functionality comes from packages you can install. Atom will also execute the code in your [init script](/hacking-atom/sections/the-init-file) on startup. In some cases, these packages and the code in the init script might be causing unexpected behavior, problems, or performance issues.

To determine if that is happening, start Atom from the terminal in safe mode:

``` command-line
$ atom --safe
```

This starts Atom, but does not load packages from `~/.atom/packages` or `~/.atom/dev/packages` and disables loading of your init script. If you can no longer reproduce the problem in safe mode, it's likely it was caused by one of the packages or the init script.

If removing or commenting out all content from the init script and starting Atom normally still produces the error, then try figuring out which package is causing trouble. Start Atom normally again and open the Settings View with <kbd class="platform-mac">Cmd+,</kbd><kbd class="platform-windows platform-linux">Ctrl+,</kbd>. Since the Settings View allows you to disable each installed package, you can disable packages one by one until you can no longer reproduce the issue. Restart Atom or reload Atom with <kbd class="platform-mac">Alt+Cmd+Ctrl+L</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+F5</kbd> after you disable each package to make sure it's completely gone.

When you find the problematic package, you can disable or uninstall the package. We strongly recommend creating an issue on the package's GitHub repository. The [Atom FAQ](https://discuss.atom.io/c/faq) has information on [how to contact the maintainers of any Atom community package or theme](https://discuss.atom.io/t/i-have-a-question-about-a-specific-atom-community-package-where-is-the-best-place-to-ask-it/25581).

#### Clearing Saved State

Atom saves a number of things about your environment when you exit in order to restore Atom to the same configuration when you next launch the program. In some cases the state that gets saved can be something undesirable that prevents Atom from working properly. In these cases, you may want to clear the state that Atom has saved.

{{#danger}}

:rotating_light: **Danger:** Clearing the saved state permanently destroys any state that Atom has saved *across all projects*. This includes unsaved changes to files you may have been editing in all projects. This is a destructive action.

{{/danger}}

Clearing the saved state can be done by opening a terminal and executing:

``` command-line
$ atom --clear-window-state
```

#### Reset to Factory Defaults

In some cases, you may want to reset Atom to "factory defaults", in other words clear all of your configuration and remove all packages. This can easily be done by opening a terminal and executing:

{{#mac}}

``` command-line
$ mv ~/.atom ~/.atom-backup
```

{{/mac}}

{{#linux}}

``` command-line
$ mv ~/.atom ~/.atom-backup
```

{{/linux}}

{{#windows}}

``` command-line
$ rename %USERPROFILE%\.atom .atom-backup
```

{{/windows}}

Once that is complete, you can launch Atom as normal. Everything will be just as if you first installed Atom.

{{#tip}}

**Tip:** The command given above doesn't delete the old configuration, just puts it somewhere that Atom can't find it. If there are pieces of the old configuration you want to retrieve, you can find them in the <span class="platform-mac platform-linux">`~/.atom-backup`</span><span class="platform-windows">`%USERPROFILE%\.atom-backup`</span> directory.

{{/tip}}

#### Check for Linked Packages

If you develop or contribute to Atom packages, there may be left-over packages linked to your `~/.atom/packages` or `~/.atom/dev/packages` directories. You can use the `apm links` command to list all linked packages:

``` command-line
$ apm links
> /Users/octocat/.atom/dev/packages (0)
> └── (no links)
> /Users/octocat/.atom/packages (1)
> └── color-picker -> /Users/octocat/github/color-picker
```

You can remove links using the `apm unlink` command:

``` command-line
$ apm unlink color-picker
> Unlinking /Users/octocat/.atom/packages/color-picker ✓
```

See `apm links --help` and `apm unlink --help` for more information on these commands.

{{#tip}}

**Tip:** You can also use `apm unlink --all` to easily unlink all packages and themes.

{{/tip}}

#### Check for Incompatible Packages

If you have packages installed that use native Node modules, when you upgrade to a new version of Atom, they might need to be rebuilt. Atom detects this and through the [incompatible-packages package](https://github.com/atom/incompatible-packages) displays an indicator in the status bar when this happens.

![Incompatible Packages Status Bar Indicator](../../images/incompatible-packages-indicator.png "Incompatible Packages Status Bar Indicator")

If you see this indicator, click it and follow the instructions.

#### Check Atom and Package Settings

In some cases, unexpected behavior might be caused by settings in Atom or in one of the packages.

Open Atom's [Settings View](https://github.com/atom/settings-view) with <kbd class="platform-mac">Cmd+,</kbd><kbd class="platform-windows platform-linux">Ctrl+,</kbd>, the <span class="platform-mac">_Atom > Preferences_</span><span class="platform-windows">_File > Preferences_</span><span class="platform-linux">_Edit > Preferences_</span> menu option, or the "Settings View: Open" command from the [Command Palette](https://github.com/atom/command-palette).

![Settings View](../../images/settings-view.png)

Check Atom's settings in the Settings View, there's a description of most configuration options in the [Basic Customization section](/using-atom/sections/basic-customization/#configuration-key-reference). For example, if you want Atom to hide the invisible symbols representing whitespace characters, disable the "Show Invisibles" option.

Some of these options are also available on a per-language basis which means that they may be different for specific languages, for example JavaScript or Python. To check the per-language settings, open the settings for the language package under the Packages tab in the Settings View, for example the language-javascript or language-python package.

Since Atom ships with a set of packages and you can also install additional packages yourself, check the list of packages and their settings. For instance, if you'd like to get rid of the vertical line in the middle of the editor, disable the [Wrap Guide package](https://atom.io/packages/wrap-guide). And if you don't like it when Atom strips trailing whitespace or ensures that there's a single trailing newline in the file, you can configure that in the [whitespace package's](https://atom.io/packages/whitespace) settings.

![Package Settings](../../images/package-settings.png)

#### Check Your Configuration

You might have defined some custom styles, keymaps or snippets in [one of your configuration files](/using-atom/sections/basic-customization/). In some situations, these personal hacks might be causing the unexpected behavior you're observing so try clearing those files and restarting Atom.

#### Check Your Keybindings

If a command is not executing when you press a key combination or the wrong command is executing, there might be an issue with the keybinding for that combination. Atom ships with the [Keybinding Resolver](https://atom.io/packages/keybinding-resolver), a neat package which helps you understand what key Atom saw you press and the command that was triggered because of it.

Show the keybinding resolver with <kbd class="platform-mac">Cmd+.</kbd><kbd class="platform-windows platform-linux">Ctrl+.</kbd> or with "Keybinding Resolver: Show" from the Command palette. With the Keybinding Resolver shown, press a key combination:

![Keybinding Resolver](../../images/keybinding-resolver.png)

The Keybinding Resolver shows you a list of keybindings that exist for the key combination, where each item in the list has the following:

* the command for the keybinding
* the CSS selector used to define the context in which the keybinding is valid
* the file in which the keybinding is defined

The keybindings are listed in two colors. All the keybindings that are matched but not executed are shown in gray. The one that is executed, if any, is shown in green. If the command you wanted to trigger isn't listed, then a keybinding for that command hasn't been loaded.

If multiple keybindings are matched, Atom determines which keybinding will be executed based on the [specificity of the selectors and the order in which they were loaded](/behind-atom/sections/keymaps-in-depth/#specificity-and-cascade-order). If the command you wanted to trigger is listed in the Keybinding Resolver, but wasn't the one that was executed, this is normally explained by one of two causes:

* The key combination was not used in the context defined by the keybinding's selector

    For example, you can't trigger the keybinding for the `tree-view:add-file` command if the Tree View is not focused.

* There is another keybinding that took precedence

    This often happens when you install a package which defines keybindings that conflict with existing keybindings. If the package's keybindings have selectors with higher specificity or were loaded later, they'll have priority over existing ones.

Atom loads core Atom keybindings and package keybindings first, and user-defined keybindings last. Since user-defined keybindings are loaded last, you can use your `keymap.cson` file to tweak the keybindings and sort out problems like these. See the [Keymaps in Depth section](/behind-atom/sections/keymaps-in-depth/) for more information.

If you notice that a package's keybindings are taking precedence over core Atom keybindings, it might be a good idea to report the issue on that package's GitHub repository. The [Atom FAQ](https://discuss.atom.io/c/faq) has information on [how to contact the maintainers of any Atom community package or theme](https://discuss.atom.io/t/i-have-a-question-about-a-specific-atom-community-package-where-is-the-best-place-to-ask-it/25581).

#### Check Font Rendering Issues

You can determine which fonts are being used to render a specific piece of text by using the Developer Tools. To open the Developer Tools press <kbd class="platform-mac">Alt+Cmd+I</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+I</kbd>. Once the Developer Tools are open, click the "Elements" tab. Use the [standard tools for finding the element](https://developers.google.com/web/tools/chrome-devtools/inspect-styles/) containing the text you want to check. Once you have selected the element, you can click the "Computed" tab in the styles pane and scroll to the bottom. The list of fonts being used will be shown there:

![Fonts In Use](../../images/fonts-in-use.png "Fonts In Use")

#### Check for Errors in the Developer Tools

When an unexpected error occurs in Atom, you will normally see a red notification which provides details about the error and allows you to create an issue on the right repository:

![Exception Notification](../../images/exception-notification.png)

Not all errors are logged with a notification so if you suspect you're experiencing an error but there's no notification, you can also look for errors in the developer tools Console tab.  To access the Console tab, press <kbd class="platform-mac">Alt-Cmd-I</kbd><kbd class="platform-windows platform-linux">Ctrl-Shift-I</kbd> to open developer tools and then click the Console tab:

![DevTools Error](../../images/devtools-error.png)

If there are multiple errors, you can scroll down to the bottom of the panel to see the most recent error.  Or while reproducing an error, you can right click in the Console tab panel, select `Clear console` to remove all Console output, and then reproduce the error to see what errors are logged to the Console tab.

{{#note}}

**Note:** When running in Dev Mode, the developer tools are automatically shown with the error logged in the Console tab.

{{/note}}

#### Find Crash Logs

{{#mac}}

When Atom crashes, you will find a crash dump in Console.app. You can launch Console.app using Spotlight or you can find it in `/Applications/Utilities/Console.app`. Once you have launched the program, you can find the latest crash dump by following these instructions:

1. Click "User Reports" in the left-most column
1. Find the latest entry in the middle column that starts with `Atom` and ends with `.crash`

Once you have the crash dump, you can save it to send in later if it is needed for debugging.

{{/mac}}

{{#windows}}

When Atom crashes, you will find a crash dump inside your `%TEMP%\Atom Crashes` directory. It will be the newest file with the `.dmp` extension. Once you have the crash dump, you can save it to send in later if it is needed for debugging.

{{/windows}}

{{#linux}}

When Atom crashes, it should write a core dump if system settings permit. In order to find whether the core dump is written and to where, consult the documentation for your distribution of Linux. Once you have the core dump, you can save it to send in later if it is needed for debugging.

{{/linux}}

#### Diagnose Startup Performance

If Atom is taking a long time to start, you can use the [Timecop package](https://github.com/atom/timecop) to get insight into where Atom spends time while loading.

![Timecop](../../images/timecop.png)

Timecop displays the following information:

* Atom startup times
* File compilation times
* Package loading and activation times
* Theme loading and activation times

If a specific package has high load or activation times, you might consider reporting an Issue to the maintainers. You can also disable the package to potentially improve future startup times.

#### Diagnose Runtime Performance

If you're experiencing performance problems in a particular situation, your [Issue reports](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#submitting-issues) will be more valuable if you include a saved profile from Chrome's CPU profiler that gives some insight into what is slow.

To run a profile, open the Developer Tools with <kbd class="platform-mac">Alt+Cmd+I</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+I</kbd>. From there:

1. Click the Profiles tab
1. Select "Collect JavaScript CPU Profile"
1. Click "Start"

![DevTools Profiler](../../images/cpu-profile-start.png)

Once that is done, then perform the slow action to capture a recording. When finished, click "Stop". Switch to the "Chart" view, and a graph of the recorded actions will appear. You can save and post the profile data by clicking "Save" next to the profile's name in the left panel.

![DevTools Profiler](../../images/cpu-profile-done.png)

To learn more, check out the [Chrome documentation on CPU profiling](https://developer.chrome.com/devtools/docs/cpu-profiling).

#### Profiling Startup Performance

If the time for loading the window looks high, you can create a CPU profile for that period using the `--profile-startup` command line flag when starting Atom:

``` command-line
$ atom --profile-startup .
```

This will automatically capture a CPU profile as Atom is loading and open the Developer Tools once Atom loads. From there:

1. Click the Profiles tab in the Developer Tools
1. Select the "startup" profile
1. Click the "Save" link for the startup profile

You can then include the startup profile in any Issue you report.

#### Check Your Build Tools

If you are having issues installing a package using `apm install`, this could be because the package has dependencies on libraries that contain native code. This means you will need to have a C++ compiler and Python installed to be able to install it. You can run `apm install --check` to see if the Atom package manager can build native code on your machine.

Check out the pre-requisites in the [build instructions](https://github.com/atom/atom/tree/master/docs/build-instructions) for your platform for more details.

#### Check if your GPU is causing the problem

If you encounter flickering or other rendering issues, you can stop Atom from using your Graphics Processing Unit (GPU) with the `--disable-gpu` Chromium flag to see if the fault lies with your GPU:

``` command-line
$ atom --disable-gpu
```

Chromium (and thus Atom) normally uses the GPU to accelerate drawing parts of the interface. `--disable-gpu` tells Atom to not even attempt to do this, and just use the CPU for rendering everything. This means that the parts of the interface that would normally be accelerated using the GPU will instead take slightly longer and render on the CPU. This likely won't make a noticeable difference, but does slightly increase the battery usage as the CPU has to work harder to do the things the GPU is optimized for.

Two other Chromium flags that are useful for debugging are `--enable-gpu-rasterization` and `--force-gpu-rasterization`:

``` command-line
$ atom --enable-gpu-rasterization --force-gpu-rasterization
```

`--enable-gpu-rasterization` allows other commands to determine how a layer tile (graphics) should be drawn and `--force-gpu-rasterization` determines that the Skia GPU backend should be used for drawing layer tiles (only valid with GPU accelerated compositing).

Be sure to use Chromium flags at the end of the terminal call if you want to use other Atom flags as they will not be executed after the Chromium flags e.g.:

``` command-line
$ atom --safe --enable-gpu-rasterization --force-gpu-rasterization
```

