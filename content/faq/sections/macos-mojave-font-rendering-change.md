---
title: MacOS Mojave font rendering change
---
### MacOS Mojave font rendering change

In [macOS Mojave v10.14.x](https://www.apple.com/macos/mojave/), Apple disabled subpixel antialiasing on all monitors by default. Previous to Mojave, subpixel antialiasing was disabled only on Retina displays or on all displays if the "LCD font smoothing" option was disabled in System Preferences. With this change in Mojave, some users have reported that [their fonts in Atom appear "thinner" or "dimmer" than they did previously.](https://github.com/atom/atom/issues/17486) It can look better or worse depending on your font and theme selections, but in all cases this is completely a side-effect of the change that Apple made to their font rendering and is outside Atom's and Electron's control.

If this change is something that you dislike, there are a couple workarounds that the community has identified.

#### Change the OS defaults

1. Execute at the Terminal: `defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`
1. Completely exit Atom
1. Start Atom again

This appears to re-enable the old "LCD font smoothing" option that was removed in Mojave. It is important to note that this is an **OS-wide** change.

#### Change your font weight

Add the following to [your stylesheet](https://flight-manual.atom.io/using-atom/sections/basic-customization/#style-tweaks):

```css
atom-text-editor {
  font-weight: bold;
}
```

This has the benefit of being a change local to Atom only if the rest of the OS looks fine to you.
