---
title: Summary
---
### Summary

If you finished this chapter, you should be an Atom-hacking master. We've discussed how you should work with CoffeeScript, and how to put it to good use in creating packages. You should also be able to do this in your own created theme now.

Even when something goes wrong, you should be able to debug this easily. But also fewer things should go wrong, because you are capable of writing great specs for Atom.

In the next chapter, we’ll go into more of a deep dive on individual internal APIs and systems of Atom, even looking at some Atom source to see how things are really getting done.
atom --version
Atom    : 1.8.0
Electron: 0.36.8
Chrome  : 47.0.2526.110
Node    : 5.1.1
%USERPROFILE%\.atom-backup
~/.atom/packages or ~/.atom/dev/packages
apm links
/Users/octocat/.atom/dev/packages (0)
└── (no links)
/Users/octocat/.atom/packages (1)
└── color-picker -> /Users/octocat/github/color-picker
See apm links --help and apm unlink --help for more information on these commands.
apm unlink --all to easily unlink all packages and themes
settings-view:open	
ctrl-,

cmd-shift-p (macOS) or ctrl-shift-p (Linux/Windows) in Atom.
-shift-p (macOS) or ctrl-shift-p (Linux/Windows) in Atom.
https://travis-ci.org/atom/whitespace.svg?branch=master
 "name": "keybinding-resolver",
  "main": "./lib/main",
  "version": "0.38.1",
  "description": "Show what commands a keybinding resolves to",
  "license": "MIT",
  "repository": "https://github.com/atom/keybinding-resolver",
  "engines": {
  '.tree-view':
  'a': 'unset!'
  
    "atom": ">0.79.0"
  },
  "dependencies": {
    "etch": "0.9.0",
    "fs-plus": "^3.0.0",
    "temp": "^0.8.1"
  },
  "devDependencies": {
    "standard": "^10.0.3"
  },
  "standard": {
    "env": {
      "atomtest": true,
      "browser": true,
      "jasmine": true,
      "node": true
    },
    "globals": [
      "atom"
    ]
  }
}
enter escape backspace delete tab home end pageup pagedown left right up down space
'atom-text-editor':
  'ctrl-o': 'abort!'
  .native-key-bindings
  .abortKeyBinding()
  .abortKeyBinding() method on the event object representing the snippets:expand command.
  # pseudo-code
editor.command 'snippets:expand', (e) =>
  if @cursorFollowsValidPrefix()
    @expandSnippet()
  else
    e.abortKeyBinding()
    
  "atom-text-editor.command-mode": {
  "i": "vim-mode:enter-insert-mode"
}
i key is fired, we walk up the DOM from the current focused element (the keydown event’s target) to the root document node. As we visit each node, we perform a selector match on the current element, and if any bindings match both the keystroke and the selector, we choose the binding with the most specific selector and dispatch its corresponding command as a custom DOM event on the current element.

In the example above, if the text editor is in command mode, typing i in the editor dispatches the vim-mode:enter-insert-mode custom DOM event rather than inserting a character. In any other mode, however, we remove the command-mode class, causing the editor to no longer match the atom-text-editor.command-mode selector. In this scenario, the keydown event passes silently through the binding system and ends up performing the default action, which is inserting an i character in the editor.

A critical step in this whole process is translating keydown event objects to human-readable keystroke descriptions like i, ctrl-k, or ctrl-alt-cmd-S. That might seem like a simple problem, but solving it on all possible keyboard layouts ended up being fairly complicated.

atom.keymaps.addKeystrokeResolver ({event}) ->
  if event.code is 'KeyG' and event.altKey and event.ctrlKey and event.type isnt 'keyup'
    return 'ctrl-@'
    atom.keymaps.addKeystrokeResolver(({event}) => {
  if (event.code === 'KeyG' && event.altKey && event.ctrlKey && event.type !== 'keyup') {
    return 'ctrl-@'
  }
})
Sometimes the problem isn't mapping the command to a key combination, the problem is that Atom doesn't recognize properly what keys you're pressing. This is due to some limitations in how Chromium reports keyboard events. But even this can be customized now.

You can add the following to your init.coffee to send Ctrl+@ when you press Ctrl+Alt+G:
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file has no header guard because it is explicily intended
// to be included more than once with different definitions of the
// macros USB_KEYMAP and USB_KEYMAP_DECLARATION.

// Data in this file was created by referencing:
//  [0] USB HID Usage Tables,
//      http://www.usb.org/developers/hidpage/Hut1_12v2.pdf
//  [1] DOM Level 3 KeyboardEvent code Values,
//      http://www.w3.org/TR/uievents-code/
//  [2] OS X <HIToolbox/Events.h>
//  [3] Linux <linux/input.h> and hid-input.c
//  [4] USB HID to PS/2 Scan Code Translation Table
//      http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
//  [5] Keyboard Scan Code Specification
//      http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/scancode.doc

// General notes:
//
//  This table provides the definition of ui::DomCode (UI Events |code|) values
//  as well as mapping between scan codes and DomCode. Some entries have no
//  defined scan codes; these are present only to allow those UI Events |code|
//  strings to be represented by DomCode. A few have a null code; these define
//  mappings with a DomCode:: value but no |code| string, typically because
//  they end up used in shortcuts but not standardized in UI Events; e.g.
//  DomCode::BRIGHTNESS_UP. Commented-out entries document USB codes that are
//  potentially interesting but not currently used.

// Linux notes:
//
//  All USB codes that are listed here and that are supported by the kernel
//  (as of 4.2) have their evdev/xkb scan codes recorded; if an evdev/xkb
//  code is 0, it is because the kernel USB driver does not handle that key.
//
//  Some Linux kernel mappings for USB keys may seem counterintuitive:
//
//  [L1] Although evdev 0x163 KEY_CLEAR exists, Linux does not use it
//       for any USB keys. Linux maps USB 0x07009c [Keyboard Clear] and
//       0x0700d8 [Keypad Clear] to KEY_DELETE "Delete", so those codes are
//       not distinguishable by applications, and UI Events "NumpadClear"
//       is therefore not supported. USB 0x0700A2 [Keyboard Clear/Again]
//       is not mapped by the kernel at all.
//
//  [L2] 'Menu' and 'Props' naming differs between evdev and USB / UI Events.
//        USB 0x010085 [System Main Menu] and USB 0x0C0040 [Menu Mode] both
//        map to evdev 0x8B KEY_MENU (which has no corresponding UI Events
//        |code|). USB 0x070076 [Keyboard Menu] does not map to KEY_MENU;
//        it maps to evdev 0x82 KEY_PROPS, which is not the same as USB and
//        UI Events "Props". USB 0x0700A3 [Props], which does correspond to
//        UI Events "Props", is not mapped by the kernel. (And all of these
//        are distinct from UI Events' "ContextMenu", which corresponds to
//        USB 0x070065 [Keyboard Application] via evdev 0x7F KEY_COMPOSE,
//        following Windows convention.)
//
//  [L3]  Linux flattens both USB 0x070048 [Keyboard Pause] and 0x0C00B1
//        [Media Pause] to 0x77 KEY_PAUSE. We map the former, since [1]
//        defines a 'Pause' code but no 'MediaPause' code.

// Windows notes:
//
//  The set of scan codes supported here may not be complete.
//
//  [W1] Windows maps both USB 0x070094 [Lang5] and USB 0x070073 [F24] to the
//       same scan code, 0x76. (Microsoft's defined scan codes for F13 - F24
//       appear to be the result of accidentally mapping an IBM Set 3 terminal
//       keyboard, rather than an IBM Set 2 PC keyboard, through the BIOS
//       2-to-1 table.)  We map 0x76 to F24 here, since Lang5 appears unused
//       in practice (its declared function, Zenkaku/Hankaku switch, is
//       conventionally placed on Backquote by Japanese keyboards).

// Macintosh notes:
//
//  The set of scan codes supported here may not be complete.
//
//  [M1] OS X maps USB 0x070049 [Insert] as well as USB 0x070075 [Help] to
//       scan code 0x72 kVK_Help. We map this to UI Events 'Insert', since
//       Apple keyboards with USB 0x070049 [Insert] labelled "Help" have not
//       been made since 2007.

USB_KEYMAP_DECLARATION {

  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x000000, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NONE), // Invalid

  // =========================================
  // Non-USB codes
  // =========================================

  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x000010, 0x0000, 0x0000, 0x0000, 0xffff, "Hyper", HYPER),
  USB_KEYMAP(0x000011, 0x0000, 0x0000, 0x0000, 0xffff, "Super", SUPER),
  USB_KEYMAP(0x000012, 0x0000, 0x0000, 0x0000, 0xffff, "Fn", FN),
  USB_KEYMAP(0x000013, 0x0000, 0x0000, 0x0000, 0xffff, "FnLock", FN_LOCK),
  USB_KEYMAP(0x000014, 0x0000, 0x0000, 0x0000, 0xffff, "Suspend", SUSPEND),
  USB_KEYMAP(0x000015, 0x0000, 0x0000, 0x0000, 0xffff, "Resume", RESUME),
  USB_KEYMAP(0x000016, 0x0000, 0x0000, 0x0000, 0xffff, "Turbo", TURBO),

  // =========================================
  // USB Usage Page 0x01: Generic Desktop Page
  // =========================================

  // Sleep could be encoded as USB#0c0032, but there's no corresponding WakeUp
  // in the 0x0c USB page.
  //            USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x010082, 0x008e, 0x0096, 0xe05f, 0xffff, "Sleep", SLEEP), // SystemSleep
  USB_KEYMAP(0x010083, 0x008f, 0x0097, 0xe063, 0xffff, "WakeUp", WAKE_UP),

  // =========================================
  // USB Usage Page 0x07: Keyboard/Keypad Page
  // =========================================

  // TODO(garykac):
  // XKB#005c ISO Level3 Shift (AltGr)
  // XKB#005e <>||
  // XKB#006d Linefeed
  // XKB#008a SunProps cf. USB#0700a3 CrSel/Props
  // XKB#008e SunOpen
  // Mac#003f kVK_Function
  // Mac#000a kVK_ISO_Section (ISO keyboards only)
  // Mac#0066 kVK_JIS_Eisu (USB#07008a Henkan?)

  //            USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x070000, 0x0000, 0x0000, 0x0000, 0xffff, NULL, USB_RESERVED),
  USB_KEYMAP(0x070001, 0x0000, 0x0000, 0x00ff, 0xffff, NULL, USB_ERROR_ROLL_OVER),
  USB_KEYMAP(0x070002, 0x0000, 0x0000, 0x00fc, 0xffff, NULL, USB_POST_FAIL),
  USB_KEYMAP(0x070003, 0x0000, 0x0000, 0x0000, 0xffff, NULL, USB_ERROR_UNDEFINED),
  USB_KEYMAP(0x070004, 0x001e, 0x0026, 0x001e, 0x0000, "KeyA", US_A), // aA
  USB_KEYMAP(0x070005, 0x0030, 0x0038, 0x0030, 0x000b, "KeyB", US_B), // bB
  USB_KEYMAP(0x070006, 0x002e, 0x0036, 0x002e, 0x0008, "KeyC", US_C), // cC
  USB_KEYMAP(0x070007, 0x0020, 0x0028, 0x0020, 0x0002, "KeyD", US_D), // dD

  USB_KEYMAP(0x070008, 0x0012, 0x001a, 0x0012, 0x000e, "KeyE", US_E), // eE
  USB_KEYMAP(0x070009, 0x0021, 0x0029, 0x0021, 0x0003, "KeyF", US_F), // fF
  USB_KEYMAP(0x07000a, 0x0022, 0x002a, 0x0022, 0x0005, "KeyG", US_G), // gG
  USB_KEYMAP(0x07000b, 0x0023, 0x002b, 0x0023, 0x0004, "KeyH", US_H), // hH
  USB_KEYMAP(0x07000c, 0x0017, 0x001f, 0x0017, 0x0022, "KeyI", US_I), // iI
  USB_KEYMAP(0x07000d, 0x0024, 0x002c, 0x0024, 0x0026, "KeyJ", US_J), // jJ
  USB_KEYMAP(0x07000e, 0x0025, 0x002d, 0x0025, 0x0028, "KeyK", US_K), // kK
  USB_KEYMAP(0x07000f, 0x0026, 0x002e, 0x0026, 0x0025, "KeyL", US_L), // lL

  USB_KEYMAP(0x070010, 0x0032, 0x003a, 0x0032, 0x002e, "KeyM", US_M), // mM
  USB_KEYMAP(0x070011, 0x0031, 0x0039, 0x0031, 0x002d, "KeyN", US_N), // nN
  USB_KEYMAP(0x070012, 0x0018, 0x0020, 0x0018, 0x001f, "KeyO", US_O), // oO
  USB_KEYMAP(0x070013, 0x0019, 0x0021, 0x0019, 0x0023, "KeyP", US_P), // pP
  USB_KEYMAP(0x070014, 0x0010, 0x0018, 0x0010, 0x000c, "KeyQ", US_Q), // qQ
  USB_KEYMAP(0x070015, 0x0013, 0x001b, 0x0013, 0x000f, "KeyR", US_R), // rR
  USB_KEYMAP(0x070016, 0x001f, 0x0027, 0x001f, 0x0001, "KeyS", US_S), // sS
  USB_KEYMAP(0x070017, 0x0014, 0x001c, 0x0014, 0x0011, "KeyT", US_T), // tT

  USB_KEYMAP(0x070018, 0x0016, 0x001e, 0x0016, 0x0020, "KeyU", US_U), // uU
  USB_KEYMAP(0x070019, 0x002f, 0x0037, 0x002f, 0x0009, "KeyV", US_V), // vV
  USB_KEYMAP(0x07001a, 0x0011, 0x0019, 0x0011, 0x000d, "KeyW", US_W), // wW
  USB_KEYMAP(0x07001b, 0x002d, 0x0035, 0x002d, 0x0007, "KeyX", US_X), // xX
  USB_KEYMAP(0x07001c, 0x0015, 0x001d, 0x0015, 0x0010, "KeyY", US_Y), // yY
  USB_KEYMAP(0x07001d, 0x002c, 0x0034, 0x002c, 0x0006, "KeyZ", US_Z), // zZ
  USB_KEYMAP(0x07001e, 0x0002, 0x000a, 0x0002, 0x0012, "Digit1", DIGIT1), // 1!
  USB_KEYMAP(0x07001f, 0x0003, 0x000b, 0x0003, 0x0013, "Digit2", DIGIT2), // 2@

  USB_KEYMAP(0x070020, 0x0004, 0x000c, 0x0004, 0x0014, "Digit3", DIGIT3), // 3#
  USB_KEYMAP(0x070021, 0x0005, 0x000d, 0x0005, 0x0015, "Digit4", DIGIT4), // 4$
  USB_KEYMAP(0x070022, 0x0006, 0x000e, 0x0006, 0x0017, "Digit5", DIGIT5), // 5%
  USB_KEYMAP(0x070023, 0x0007, 0x000f, 0x0007, 0x0016, "Digit6", DIGIT6), // 6^
  USB_KEYMAP(0x070024, 0x0008, 0x0010, 0x0008, 0x001a, "Digit7", DIGIT7), // 7&
  USB_KEYMAP(0x070025, 0x0009, 0x0011, 0x0009, 0x001c, "Digit8", DIGIT8), // 8*
  USB_KEYMAP(0x070026, 0x000a, 0x0012, 0x000a, 0x0019, "Digit9", DIGIT9), // 9(
  USB_KEYMAP(0x070027, 0x000b, 0x0013, 0x000b, 0x001d, "Digit0", DIGIT0), // 0)

  USB_KEYMAP(0x070028, 0x001c, 0x0024, 0x001c, 0x0024, "Enter", ENTER),
  USB_KEYMAP(0x070029, 0x0001, 0x0009, 0x0001, 0x0035, "Escape", ESCAPE),
  USB_KEYMAP(0x07002a, 0x000e, 0x0016, 0x000e, 0x0033, "Backspace", BACKSPACE),
  USB_KEYMAP(0x07002b, 0x000f, 0x0017, 0x000f, 0x0030, "Tab", TAB),
  USB_KEYMAP(0x07002c, 0x0039, 0x0041, 0x0039, 0x0031, "Space", SPACE), // Spacebar
  USB_KEYMAP(0x07002d, 0x000c, 0x0014, 0x000c, 0x001b, "Minus", MINUS), // -_
  USB_KEYMAP(0x07002e, 0x000d, 0x0015, 0x000d, 0x0018, "Equal", EQUAL), // =+
  USB_KEYMAP(0x07002f, 0x001a, 0x0022, 0x001a, 0x0021, "BracketLeft", BRACKET_LEFT),

  USB_KEYMAP(0x070030, 0x001b, 0x0023, 0x001b, 0x001e, "BracketRight", BRACKET_RIGHT),
  USB_KEYMAP(0x070031, 0x002b, 0x0033, 0x002b, 0x002a, "Backslash", BACKSLASH), // \|
  // USB#070032 never appears on keyboards that have USB#070031.
  // Platforms use the same scancode as for the two keys.
  // Hence this code can only be generated synthetically
  // (e.g. in a DOM Level 3 KeyboardEvent).
  // The keycap varies on international keyboards:
  //   Dan: '*  Dutch: <>  Ger: #'  UK: #~
  // TODO(garykac): Verify Mac intl keyboard.
  USB_KEYMAP(0x070032, 0x0000, 0x0000, 0x0000, 0xffff, "IntlHash", INTL_HASH),
  USB_KEYMAP(0x070033, 0x0027, 0x002f, 0x0027, 0x0029, "Semicolon", SEMICOLON), // ;:
  USB_KEYMAP(0x070034, 0x0028, 0x0030, 0x0028, 0x0027, "Quote", QUOTE), // '"
  USB_KEYMAP(0x070035, 0x0029, 0x0031, 0x0029, 0x0032, "Backquote", BACKQUOTE), // `~
  USB_KEYMAP(0x070036, 0x0033, 0x003b, 0x0033, 0x002b, "Comma", COMMA), // ,<
  USB_KEYMAP(0x070037, 0x0034, 0x003c, 0x0034, 0x002f, "Period", PERIOD), // .>

  USB_KEYMAP(0x070038, 0x0035, 0x003d, 0x0035, 0x002c, "Slash", SLASH), // /?
  // TODO(garykac): CapsLock requires special handling for each platform.
  USB_KEYMAP(0x070039, 0x003a, 0x0042, 0x003a, 0x0039, "CapsLock", CAPS_LOCK),
  USB_KEYMAP(0x07003a, 0x003b, 0x0043, 0x003b, 0x007a, "F1", F1),
  USB_KEYMAP(0x07003b, 0x003c, 0x0044, 0x003c, 0x0078, "F2", F2),
  USB_KEYMAP(0x07003c, 0x003d, 0x0045, 0x003d, 0x0063, "F3", F3),
  USB_KEYMAP(0x07003d, 0x003e, 0x0046, 0x003e, 0x0076, "F4", F4),
  USB_KEYMAP(0x07003e, 0x003f, 0x0047, 0x003f, 0x0060, "F5", F5),
  USB_KEYMAP(0x07003f, 0x0040, 0x0048, 0x0040, 0x0061, "F6", F6),

  USB_KEYMAP(0x070040, 0x0041, 0x0049, 0x0041, 0x0062, "F7", F7),
  USB_KEYMAP(0x070041, 0x0042, 0x004a, 0x0042, 0x0064, "F8", F8),
  USB_KEYMAP(0x070042, 0x0043, 0x004b, 0x0043, 0x0065, "F9", F9),
  USB_KEYMAP(0x070043, 0x0044, 0x004c, 0x0044, 0x006d, "F10", F10),
  USB_KEYMAP(0x070044, 0x0057, 0x005f, 0x0057, 0x0067, "F11", F11),
  USB_KEYMAP(0x070045, 0x0058, 0x0060, 0x0058, 0x006f, "F12", F12),
  // PrintScreen is effectively F13 on Mac OS X.
  USB_KEYMAP(0x070046, 0x0063, 0x006b, 0xe037, 0xffff, "PrintScreen", PRINT_SCREEN),
  USB_KEYMAP(0x070047, 0x0046, 0x004e, 0x0046, 0xffff, "ScrollLock", SCROLL_LOCK),

  USB_KEYMAP(0x070048, 0x0077, 0x007f, 0x0045, 0xffff, "Pause", PAUSE),
  // USB#0x070049 Insert, labeled "Help/Insert" on Mac -- see note M1 at top.
  USB_KEYMAP(0x070049, 0x006e, 0x0076, 0xe052, 0x0072, "Insert", INSERT),
  USB_KEYMAP(0x07004a, 0x0066, 0x006e, 0xe047, 0x0073, "Home", HOME),
  USB_KEYMAP(0x07004b, 0x0068, 0x0070, 0xe049, 0x0074, "PageUp", PAGE_UP),
  // Delete (Forward Delete) named DEL because DELETE conflicts with <windows.h>
  USB_KEYMAP(0x07004c, 0x006f, 0x0077, 0xe053, 0x0075, "Delete", DEL),
  USB_KEYMAP(0x07004d, 0x006b, 0x0073, 0xe04f, 0x0077, "End", END),
  USB_KEYMAP(0x07004e, 0x006d, 0x0075, 0xe051, 0x0079, "PageDown", PAGE_DOWN),
  USB_KEYMAP(0x07004f, 0x006a, 0x0072, 0xe04d, 0x007c, "ArrowRight", ARROW_RIGHT),

  USB_KEYMAP(0x070050, 0x0069, 0x0071, 0xe04b, 0x007b, "ArrowLeft", ARROW_LEFT),
  USB_KEYMAP(0x070051, 0x006c, 0x0074, 0xe050, 0x007d, "ArrowDown", ARROW_DOWN),
  USB_KEYMAP(0x070052, 0x0067, 0x006f, 0xe048, 0x007e, "ArrowUp", ARROW_UP),
  USB_KEYMAP(0x070053, 0x0045, 0x004d, 0xe045, 0x0047, "NumLock", NUM_LOCK),
  USB_KEYMAP(0x070054, 0x0062, 0x006a, 0xe035, 0x004b, "NumpadDivide", NUMPAD_DIVIDE),
  USB_KEYMAP(0x070055, 0x0037, 0x003f, 0x0037, 0x0043, "NumpadMultiply",
             NUMPAD_MULTIPLY),  // Keypad_*
  USB_KEYMAP(0x070056, 0x004a, 0x0052, 0x004a, 0x004e, "NumpadSubtract",
             NUMPAD_SUBTRACT),  // Keypad_-
  USB_KEYMAP(0x070057, 0x004e, 0x0056, 0x004e, 0x0045, "NumpadAdd", NUMPAD_ADD),

  USB_KEYMAP(0x070058, 0x0060, 0x0068, 0xe01c, 0x004c, "NumpadEnter", NUMPAD_ENTER),
  USB_KEYMAP(0x070059, 0x004f, 0x0057, 0x004f, 0x0053, "Numpad1", NUMPAD1), // +End
  USB_KEYMAP(0x07005a, 0x0050, 0x0058, 0x0050, 0x0054, "Numpad2", NUMPAD2), // +Down
  USB_KEYMAP(0x07005b, 0x0051, 0x0059, 0x0051, 0x0055, "Numpad3", NUMPAD3), // +PageDn
  USB_KEYMAP(0x07005c, 0x004b, 0x0053, 0x004b, 0x0056, "Numpad4", NUMPAD4), // +Left
  USB_KEYMAP(0x07005d, 0x004c, 0x0054, 0x004c, 0x0057, "Numpad5", NUMPAD5), //
  USB_KEYMAP(0x07005e, 0x004d, 0x0055, 0x004d, 0x0058, "Numpad6", NUMPAD6), // +Right
  USB_KEYMAP(0x07005f, 0x0047, 0x004f, 0x0047, 0x0059, "Numpad7", NUMPAD7), // +Home

  USB_KEYMAP(0x070060, 0x0048, 0x0050, 0x0048, 0x005b, "Numpad8", NUMPAD8), // +Up
  USB_KEYMAP(0x070061, 0x0049, 0x0051, 0x0049, 0x005c, "Numpad9", NUMPAD9), // +PageUp
  USB_KEYMAP(0x070062, 0x0052, 0x005a, 0x0052, 0x0052, "Numpad0", NUMPAD0), // +Insert
  USB_KEYMAP(0x070063, 0x0053, 0x005b, 0x0053, 0x0041, "NumpadDecimal",
             NUMPAD_DECIMAL),  // Keypad_. Delete
  // USB#070064 is not present on US keyboard.
  // This key is typically located near LeftShift key.
  // The keycap varies on international keyboards:
  //   Dan: <> Dutch: ][ Ger: <> UK: \|
  USB_KEYMAP(0x070064, 0x0056, 0x005e, 0x0056, 0x000a, "IntlBackslash", INTL_BACKSLASH),
  // USB#0x070065 Application Menu (next to RWin key) -- see note L2 at top.
  USB_KEYMAP(0x070065, 0x007f, 0x0087, 0xe05d, 0x006e, "ContextMenu", CONTEXT_MENU),
  USB_KEYMAP(0x070066, 0x0074, 0x007c, 0xe05e, 0xffff, "Power", POWER),
  USB_KEYMAP(0x070067, 0x0075, 0x007d, 0x0059, 0x0051, "NumpadEqual", NUMPAD_EQUAL),

  USB_KEYMAP(0x070068, 0x00b7, 0x00bf, 0x0064, 0x0069, "F13", F13),
  USB_KEYMAP(0x070069, 0x00b8, 0x00c0, 0x0065, 0x006b, "F14", F14),
  USB_KEYMAP(0x07006a, 0x00b9, 0x00c1, 0x0066, 0x0071, "F15", F15),
  USB_KEYMAP(0x07006b, 0x00ba, 0x00c2, 0x0067, 0x006a, "F16", F16),
  USB_KEYMAP(0x07006c, 0x00bb, 0x00c3, 0x0068, 0x0040, "F17", F17),
  USB_KEYMAP(0x07006d, 0x00bc, 0x00c4, 0x0069, 0x004f, "F18", F18),
  USB_KEYMAP(0x07006e, 0x00bd, 0x00c5, 0x006a, 0x0050, "F19", F19),
  USB_KEYMAP(0x07006f, 0x00be, 0x00c6, 0x006b, 0x005a, "F20", F20),

  USB_KEYMAP(0x070070, 0x00bf, 0x00c7, 0x006c, 0xffff, "F21", F21),
  USB_KEYMAP(0x070071, 0x00c0, 0x00c8, 0x006d, 0xffff, "F22", F22),
  USB_KEYMAP(0x070072, 0x00c1, 0x00c9, 0x006e, 0xffff, "F23", F23),
  // USB#0x070073 -- see note W1 at top.
  USB_KEYMAP(0x070073, 0x00c2, 0x00ca, 0x0076, 0xffff, "F24", F24),
  USB_KEYMAP(0x070074, 0x0086, 0x008e, 0x0000, 0xffff, "Open", OPEN), // Execute
  // USB#0x070075 Help -- see note M1 at top.
  USB_KEYMAP(0x070075, 0x008a, 0x0092, 0xe03b, 0xffff, "Help", HELP),
  // USB#0x070076 Keyboard Menu -- see note L2 at top.
  //USB_KEYMAP(0x070076, 0x0000, 0x0000, 0x0000, 0xffff, NULL, MENU), // Menu
  USB_KEYMAP(0x070077, 0x0084, 0x008c, 0x0000, 0xffff, "Select", SELECT), // Select

  //USB_KEYMAP(0x070078, 0x0080, 0x0088, 0x0000, 0xffff, NULL, STOP), // Stop
  USB_KEYMAP(0x070079, 0x0081, 0x0089, 0x0000, 0xffff, "Again", AGAIN), // Again
  USB_KEYMAP(0x07007a, 0x0083, 0x008b, 0xe008, 0xffff, "Undo", UNDO),
  USB_KEYMAP(0x07007b, 0x0089, 0x0091, 0xe017, 0xffff, "Cut", CUT),
  USB_KEYMAP(0x07007c, 0x0085, 0x008d, 0xe018, 0xffff, "Copy", COPY),
  USB_KEYMAP(0x07007d, 0x0087, 0x008f, 0xe00a, 0xffff, "Paste", PASTE),
  USB_KEYMAP(0x07007e, 0x0088, 0x0090, 0x0000, 0xffff, "Find", FIND), // Find
  USB_KEYMAP(0x07007f, 0x0071, 0x0079, 0xe020, 0x004a, "AudioVolumeMute", VOLUME_MUTE),

  USB_KEYMAP(0x070080, 0x0073, 0x007b, 0xe030, 0x0048, "AudioVolumeUp", VOLUME_UP),
  USB_KEYMAP(0x070081, 0x0072, 0x007a, 0xe02e, 0x0049, "AudioVolumeDown", VOLUME_DOWN),
  //USB_KEYMAP(0x070082, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_CAPS_LOCK),
  //USB_KEYMAP(0x070083, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_NUM_LOCK),
  //USB_KEYMAP(0x070084, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_SCROLL_LOCK),
  USB_KEYMAP(0x070085, 0x0079, 0x0081, 0x007e, 0x005f, "NumpadComma", NUMPAD_COMMA),

  // International1
  // USB#070086 is used on AS/400 keyboards. Standard Keypad_= is USB#070067.
  //USB_KEYMAP(0x070086, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_EQUAL),
  // USB#070087 is used for Brazilian /? and Japanese _ 'ro'.
  USB_KEYMAP(0x070087, 0x0059, 0x0061, 0x0073, 0x005e, "IntlRo", INTL_RO),
  // International2
  // USB#070088 is used as Japanese Hiragana/Katakana key.
  USB_KEYMAP(0x070088, 0x005d, 0x0065, 0x0070, 0x0068, "KanaMode", KANA_MODE),
  // International3
  // USB#070089 is used as Japanese Yen key.
  USB_KEYMAP(0x070089, 0x007c, 0x0084, 0x007d, 0x005d, "IntlYen", INTL_YEN),
  // International4
  // USB#07008a is used as Japanese Henkan (Convert) key.
  USB_KEYMAP(0x07008a, 0x005c, 0x0064, 0x0079, 0xffff, "Convert", CONVERT),
  // International5
  // USB#07008b is used as Japanese Muhenkan (No-convert) key.
  USB_KEYMAP(0x07008b, 0x005e, 0x0066, 0x007b, 0xffff, "NonConvert", NON_CONVERT),
  //USB_KEYMAP(0x07008c, 0x005f, 0x0067, 0x005c, 0xffff, NULL, INTERNATIONAL6),
  //USB_KEYMAP(0x07008d, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL7),
  //USB_KEYMAP(0x07008e, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL8),
  //USB_KEYMAP(0x07008f, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL9),

  // LANG1
  // USB#070090 is used as Korean Hangul/English toggle key.
  USB_KEYMAP(0x070090, 0x007a, 0x0082, 0x0072, 0xffff, "Lang1", LANG1),
  // LANG2
  // USB#070091 is used as Korean Hanja conversion key.
  USB_KEYMAP(0x070091, 0x007b, 0x0083, 0x0071, 0xffff, "Lang2", LANG2),
  // LANG3
  // USB#070092 is used as Japanese Katakana key.
  USB_KEYMAP(0x070092, 0x005a, 0x0062, 0x0078, 0xffff, "Lang3", LANG3),
  // LANG4
  // USB#070093 is used as Japanese Hiragana key.
  USB_KEYMAP(0x070093, 0x005b, 0x0063, 0x0077, 0xffff, "Lang4", LANG4),
  // LANG5
  // USB#070094 is used as Japanese Zenkaku/Hankaku (Fullwidth/halfwidth) key.
  // Not mapped on Windows -- see note W1 at top.
  USB_KEYMAP(0x070094, 0x0055, 0x005d, 0x0000, 0xffff, "Lang5", LANG5),
  //USB_KEYMAP(0x070095, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG6), // LANG6
  //USB_KEYMAP(0x070096, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG7), // LANG7
  //USB_KEYMAP(0x070097, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG8), // LANG8
  //USB_KEYMAP(0x070098, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG9), // LANG9

  //USB_KEYMAP(0x070099, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ALTERNATE_ERASE),
  //USB_KEYMAP(0x07009a, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SYS_REQ), // /Attention
  USB_KEYMAP(0x07009b, 0x0000, 0x0000, 0x0000, 0xffff, "Abort", ABORT), // Cancel
  // USB#0x07009c Keyboard Clear -- see note L1 at top.
  //USB_KEYMAP(0x07009c, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CLEAR), // Clear
  //USB_KEYMAP(0x07009d, 0x0000, 0x0000, 0x0000, 0xffff, NULL, PRIOR), // Prior
  //USB_KEYMAP(0x07009e, 0x0000, 0x0000, 0x0000, 0xffff, NULL, RETURN), // Return
  //USB_KEYMAP(0x07009f, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SEPARATOR), // Separator

  //USB_KEYMAP(0x0700a0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, OUT), // Out
  //USB_KEYMAP(0x0700a1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, OPER), // Oper
  //USB_KEYMAP(0x0700a2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CLEAR_AGAIN),
  // USB#0x0700a3 Props -- see note L2 at top.
  USB_KEYMAP(0x0700a3, 0x0000, 0x0000, 0x0000, 0xffff, "Props", PROPS), // CrSel/Props
  //USB_KEYMAP(0x0700a4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, EX_SEL), // ExSel

  //USB_KEYMAP(0x0700b0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_00),
  //USB_KEYMAP(0x0700b1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_000),
  //USB_KEYMAP(0x0700b2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, THOUSANDS_SEPARATOR),
  //USB_KEYMAP(0x0700b3, 0x0000, 0x0000, 0x0000, 0xffff, NULL, DECIMAL_SEPARATOR),
  //USB_KEYMAP(0x0700b4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CURRENCY_UNIT),
  //USB_KEYMAP(0x0700b5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CURRENCY_SUBUNIT),
  USB_KEYMAP(0x0700b6, 0x00b3, 0x00bb, 0x0000, 0xffff, "NumpadParenLeft",
             NUMPAD_PAREN_LEFT),   // Keypad_(
  USB_KEYMAP(0x0700b7, 0x00b4, 0x00bc, 0x0000, 0xffff, "NumpadParenRight",
             NUMPAD_PAREN_RIGHT),  // Keypad_)

  //USB_KEYMAP(0x0700b8, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BRACE_LEFT),
  //USB_KEYMAP(0x0700b9, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BRACE_RIGHT),
  //USB_KEYMAP(0x0700ba, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_TAB),
  USB_KEYMAP(0x0700bb, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadBackspace",
             NUMPAD_BACKSPACE),  // Keypad_Backspace
  //USB_KEYMAP(0x0700bc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_A),
  //USB_KEYMAP(0x0700bd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_B),
  //USB_KEYMAP(0x0700be, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_C),
  //USB_KEYMAP(0x0700bf, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_D),

  //USB_KEYMAP(0x0700c0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_E),
  //USB_KEYMAP(0x0700c1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_F),
  //USB_KEYMAP(0x0700c2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_XOR),
  //USB_KEYMAP(0x0700c3, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_CARAT),
  //USB_KEYMAP(0x0700c4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_PERCENT),
  //USB_KEYMAP(0x0700c5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_LESS_THAN),
  //USB_KEYMAP(0x0700c6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_GREATER_THAN),
  //USB_KEYMAP(0x0700c7, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_AMERSAND),

  //USB_KEYMAP(0x0700c8, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_DOUBLE_AMPERSAND),
  //USB_KEYMAP(0x0700c9, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_VERTICAL_BAR),
  //USB_KEYMAP(0x0700ca, 0x0000, 0x0000, 0x0000, 0xffff, NULL,
  //           NUMPAD_DOUBLE_VERTICAL_BAR),  // Keypad_||
  //USB_KEYMAP(0x0700cb, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_COLON),
  //USB_KEYMAP(0x0700cc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_NUMBER),
  //USB_KEYMAP(0x0700cd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_SPACE),
  //USB_KEYMAP(0x0700ce, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_AT),
  //USB_KEYMAP(0x0700cf, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_EXCLAMATION),

  USB_KEYMAP(0x0700d0, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryStore",
             NUMPAD_MEMORY_STORE),  // Keypad_MemoryStore
  USB_KEYMAP(0x0700d1, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryRecall",
             NUMPAD_MEMORY_RECALL),  // Keypad_MemoryRecall
  USB_KEYMAP(0x0700d2, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryClear",
             NUMPAD_MEMORY_CLEAR),  // Keypad_MemoryClear
  USB_KEYMAP(0x0700d3, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryAdd",
             NUMPAD_MEMORY_ADD),  // Keypad_MemoryAdd
  USB_KEYMAP(0x0700d4, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemorySubtract",
             NUMPAD_MEMORY_SUBTRACT),  // Keypad_MemorySubtract
  //USB_KEYMAP(0x0700d5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_MEMORY_MULTIPLE),
  //USB_KEYMAP(0x0700d6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_MEMORY_DIVIDE),
  USB_KEYMAP(0x0700d7, 0x0076, 0x007e, 0x0000, 0xffff, NULL, NUMPAD_SIGN_CHANGE), // +/-
  // USB#0x0700d8 Keypad Clear -- see note L1 at top.
  USB_KEYMAP(0x0700d8, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadClear", NUMPAD_CLEAR),
  USB_KEYMAP(0x0700d9, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadClearEntry",
             NUMPAD_CLEAR_ENTRY),  // Keypad_ClearEntry
  //USB_KEYMAP(0x0700da, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BINARY),
  //USB_KEYMAP(0x0700db, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_OCTAL),
  //USB_KEYMAP(0x0700dc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_DECIMAL),
  //USB_KEYMAP(0x0700dd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_HEXADECIMAL),

  // USB#0700de - #0700df are reserved.
  USB_KEYMAP(0x0700e0, 0x001d, 0x0025, 0x001d, 0x003b, "ControlLeft", CONTROL_LEFT),
  USB_KEYMAP(0x0700e1, 0x002a, 0x0032, 0x002a, 0x0038, "ShiftLeft", SHIFT_LEFT),
  // USB#0700e2: left Alt key (Mac left Option key).
  USB_KEYMAP(0x0700e2, 0x0038, 0x0040, 0x0038, 0x003a, "AltLeft", ALT_LEFT),
  // USB#0700e3: left GUI key, e.g. Windows, Mac Command, ChromeOS Search.
  USB_KEYMAP(0x0700e3, 0x007d, 0x0085, 0xe05b, 0x0037, "MetaLeft", META_LEFT),
  USB_KEYMAP(0x0700e4, 0x0061, 0x0069, 0xe01d, 0x003e, "ControlRight", CONTROL_RIGHT),
  USB_KEYMAP(0x0700e5, 0x0036, 0x003e, 0x0036, 0x003c, "ShiftRight", SHIFT_RIGHT),
  // USB#0700e6: right Alt key (Mac right Option key).
  USB_KEYMAP(0x0700e6, 0x0064, 0x006c, 0xe038, 0x003d, "AltRight", ALT_RIGHT),
  // USB#0700e7: right GUI key, e.g. Windows, Mac Command, ChromeOS Search.
  USB_KEYMAP(0x0700e7, 0x007e, 0x0086, 0xe05c, 0x0036, "MetaRight", META_RIGHT),

  // USB#0700e8 - #07ffff are reserved

  // ==================================
  // USB Usage Page 0x0c: Consumer Page
  // ==================================
  // AL = Application Launch
  // AC = Application Control

  // TODO(garykac): Many XF86 keys have multiple scancodes mapping to them.
  // We need to map all of these into a canonical USB scancode without
  // confusing the reverse-lookup - most likely by simply returning the first
  // found match.

  // TODO(garykac): Find appropriate mappings for:
  // Win#e03c Music - USB#0c0193 is AL_AVCapturePlayback
  // Win#e064 Pictures
  // XKB#0080 XF86LaunchA
  // XKB#0099 XF86Send
  // XKB#009b XF86Xfer
  // XKB#009c XF86Launch1
  // XKB#009d XF86Launch2
  // XKB... remaining XF86 keys

  // KEY_BRIGHTNESS* added in Linux 3.16
  // http://www.usb.org/developers/hidpage/HUTRR41.pdf
  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x0c0060, 0x0166, 0x016e, 0x0000, 0xffff, NULL, INFO),
  USB_KEYMAP(0x0c0061, 0x0172, 0x017a, 0x0000, 0xffff, NULL, CLOSED_CAPTION_TOGGLE),
  USB_KEYMAP(0x0c006f, 0x00e1, 0x00e9, 0x0000, 0xffff, "BrightnessUp", BRIGHTNESS_UP),
  USB_KEYMAP(0x0c0070, 0x00e0, 0x00e8, 0x0000, 0xffff, "BrightnessDown",
             BRIGHTNESS_DOWN),  // Display Brightness Decrement
  USB_KEYMAP(0x0c0072, 0x01af, 0x01b7, 0x0000, 0xffff, NULL, BRIGHTNESS_TOGGLE),
  USB_KEYMAP(0x0c0073, 0x0250, 0x0258, 0x0000, 0xffff, NULL, BRIGHTNESS_MINIMIUM),
  USB_KEYMAP(0x0c0074, 0x0251, 0x0259, 0x0000, 0xffff, NULL, BRIGHTNESS_MAXIMUM),
  USB_KEYMAP(0x0c0075, 0x00f4, 0x00fc, 0x0000, 0xffff, NULL, BRIGHTNESS_AUTO),
  USB_KEYMAP(0x0c0083, 0x0195, 0x019d, 0x0000, 0xffff, NULL, MEDIA_LAST),
  USB_KEYMAP(0x0c008c, 0x00a9, 0x00b1, 0x0000, 0xffff, NULL, LAUNCH_PHONE),
  USB_KEYMAP(0x0c008d, 0x016a, 0x0172, 0x0000, 0xffff, NULL, PROGRAM_GUIDE),
  USB_KEYMAP(0x0c0094, 0x00ae, 0x00b6, 0x0000, 0xffff, NULL, EXIT),
  USB_KEYMAP(0x0c009c, 0x019a, 0x01a2, 0x0000, 0xffff, NULL, CHANNEL_UP),
  USB_KEYMAP(0x0c009d, 0x019b, 0x01a3, 0x0000, 0xffff, NULL, CHANNEL_DOWN),

  //              USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x0c00b0, 0x00cf, 0x00d7, 0x0000, 0xffff, "MediaPlay", MEDIA_PLAY),
  //USB_KEYMAP(0x0c00b1, 0x0077, 0x007f, 0x0000, 0xffff, "MediaPause", MEDIA_PAUSE),
  USB_KEYMAP(0x0c00b2, 0x00a7, 0x00af, 0x0000, 0xffff, "MediaRecord", MEDIA_RECORD),
  USB_KEYMAP(0x0c00b3, 0x00d0, 0x00d8, 0x0000, 0xffff, "MediaFastForward", MEDIA_FAST_FORWARD),
  USB_KEYMAP(0x0c00b4, 0x00a8, 0x00b0, 0x0000, 0xffff, "MediaRewind", MEDIA_REWIND),
  USB_KEYMAP(0x0c00b5, 0x00a3, 0x00ab, 0xe019, 0xffff, "MediaTrackNext",
             MEDIA_TRACK_NEXT),
  USB_KEYMAP(0x0c00b6, 0x00a5, 0x00ad, 0xe010, 0xffff, "MediaTrackPrevious",
             MEDIA_TRACK_PREVIOUS),
  USB_KEYMAP(0x0c00b7, 0x00a6, 0x00ae, 0xe024, 0xffff, "MediaStop", MEDIA_STOP),
  USB_KEYMAP(0x0c00b8, 0x00a1, 0x00a9, 0xe02c, 0xffff, "Eject", EJECT),
  USB_KEYMAP(0x0c00cd, 0x00a4, 0x00ac, 0xe022, 0xffff, "MediaPlayPause",
             MEDIA_PLAY_PAUSE),
  USB_KEYMAP(0x0c00cf, 0x0246, 0x024e, 0x0000, 0xffff, NULL, SPEECH_INPUT_TOGGLE),
  USB_KEYMAP(0x0c00e5, 0x00d1, 0x00d9, 0x0000, 0xffff, NULL, BASS_BOOST),
  //USB_KEYMAP(0x0c00e6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SURROUND_MODE),
  //USB_KEYMAP(0x0c0150, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BALANCE_RIGHT),
  //USB_KEYMAP(0x0c0151, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BALANCE_LEFT ),
  //USB_KEYMAP(0x0c0152, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BASS_INCREMENT),
  //USB_KEYMAP(0x0c0153, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BASS_DECREMENT),
  //USB_KEYMAP(0x0c0154, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_TREBLE_INCREMENT),
  //USB_KEYMAP(0x0c0155, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_TREBLE_DECREMENT),
  // USB#0c0183: AL Consumer Control Configuration
  USB_KEYMAP(0x0c0183, 0x00ab, 0x00b3, 0xe06d, 0xffff, "MediaSelect", MEDIA_SELECT),
  USB_KEYMAP(0x0c0184, 0x01a5, 0x01ad, 0x0000, 0xffff, NULL, LAUNCH_WORD_PROCESSOR),
  USB_KEYMAP(0x0c0186, 0x01a7, 0x01af, 0x0000, 0xffff, NULL, LAUNCH_SPREADSHEET),
  // USB#0x0c018a AL_EmailReader
  USB_KEYMAP(0x0c018a, 0x009b, 0x00a3, 0xe06c, 0xffff, "LaunchMail", LAUNCH_MAIL),
  // USB#0x0c018d: AL Contacts/Address Book
  USB_KEYMAP(0x0c018d, 0x01ad, 0x01b5, 0x0000, 0xffff, NULL, LAUNCH_CONTACTS),
  // USB#0x0c018e: AL Calendar/Schedule
  USB_KEYMAP(0x0c018e, 0x018d, 0x0195, 0x0000, 0xffff, NULL, LAUNCH_CALENDAR),
  // USB#0x0c018f AL Task/Project Manager
  //USB_KEYMAP(0x0c018f, 0x0241, 0x0249, 0x0000, 0xffff, NULL, LAUNCH_TASK_MANAGER),
  // USB#0x0c0190: AL Log/Journal/Timecard
  //USB_KEYMAP(0x0c0190, 0x0242, 0x024a, 0x0000, 0xffff, NULL, LAUNCH_LOG),
  // USB#0x0c0192: AL_Calculator
  USB_KEYMAP(0x0c0192, 0x008c, 0x0094, 0xe021, 0xffff, "LaunchApp2", LAUNCH_APP2),
  // USB#0c0194: My Computer (AL_LocalMachineBrowser)
  USB_KEYMAP(0x0c0194, 0x0090, 0x0098, 0xe06b, 0xffff, "LaunchApp1", LAUNCH_APP1),
  USB_KEYMAP(0x0c0196, 0x0096, 0x009e, 0x0000, 0xffff, NULL, LAUNCH_INTERNET_BROWSER),
  USB_KEYMAP(0x0c019C, 0x01b1, 0x01b9, 0x0000, 0xffff, NULL, LOG_OFF),
  // USB#0x0c019e: AL Terminal Lock/Screensaver
  USB_KEYMAP(0x0c019e, 0x0098, 0x00a0, 0x0000, 0xffff, NULL, LOCK_SCREEN),
  // USB#0x0c019f AL Control Panel
  USB_KEYMAP(0x0c019f, 0x0243, 0x024b, 0x0000, 0xffff, NULL, LAUNCH_CONTROL_PANEL),
  // USB#0x0c01a2: AL Select Task/Application
  USB_KEYMAP(0x0c01a2, 0x0244, 0x024c, 0x0000, 0xffff, "SelectTask", SELECT_TASK),
  // USB#0x0c01a7: AL_Documents
  USB_KEYMAP(0x0c01a7, 0x00eb, 0x00f3, 0x0000, 0xffff, NULL, LAUNCH_DOCUMENTS),
  USB_KEYMAP(0x0c01ab, 0x01b0, 0x01b8, 0x0000, 0xffff, NULL, SPELL_CHECK),
  // USB#0x0c01ae: AL Keyboard Layout
  USB_KEYMAP(0x0c01ae, 0x0176, 0x017e, 0x0000, 0xffff, NULL, LAUNCH_KEYBOARD_LAYOUT),
  USB_KEYMAP(0x0c01b1, 0x0245, 0x024d, 0x0000, 0xffff, "LaunchScreenSaver",
             LAUNCH_SCREEN_SAVER),  // AL Screen Saver
  // USB#0c01b4: Home Directory (AL_FileBrowser) (Explorer)
  //USB_KEYMAP(0x0c01b4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LAUNCH_FILE_BROWSER),
  // USB#0x0c01b7: AL Audio Browser
  USB_KEYMAP(0x0c01b7, 0x0188, 0x0190, 0x0000, 0xffff, NULL, LAUNCH_AUDIO_BROWSER),
  // USB#0x0c0201: AC New
  USB_KEYMAP(0x0c0201, 0x00b5, 0x00bd, 0x0000, 0xffff, NULL, NEW),
  // USB#0x0c0203: AC Close
  USB_KEYMAP(0x0c0203, 0x00ce, 0x00d6, 0x0000, 0xffff, NULL, CLOSE),
  // USB#0x0c0207: AC Close
  USB_KEYMAP(0x0c0207, 0x00ea, 0x00f2, 0x0000, 0xffff, NULL, SAVE),
  // USB#0x0c0208: AC Print
  USB_KEYMAP(0x0c0208, 0x00d2, 0x00da, 0x0000, 0xffff, NULL, PRINT),
  // USB#0x0c0221:  AC_Search
  USB_KEYMAP(0x0c0221, 0x00d9, 0x00e1, 0xe065, 0xffff, "BrowserSearch", BROWSER_SEARCH),
  // USB#0x0c0223:  AC_Home
  USB_KEYMAP(0x0c0223, 0x00ac, 0x00b4, 0xe032, 0xffff, "BrowserHome", BROWSER_HOME),
  // USB#0x0c0224:  AC_Back
  USB_KEYMAP(0x0c0224, 0x009e, 0x00a6, 0xe06a, 0xffff, "BrowserBack", BROWSER_BACK),
  // USB#0x0c0225:  AC_Forward
  USB_KEYMAP(0x0c0225, 0x009f, 0x00a7, 0xe069, 0xffff, "BrowserForward",
             BROWSER_FORWARD),
  // USB#0x0c0226:  AC_Stop
  USB_KEYMAP(0x0c0226, 0x0080, 0x0088, 0xe068, 0xffff, "BrowserStop", BROWSER_STOP),
  // USB#0x0c0227:  AC_Refresh (Reload)
  USB_KEYMAP(0x0c0227, 0x00ad, 0x00b5, 0xe067, 0xffff, "BrowserRefresh",
             BROWSER_REFRESH),
  // USB#0x0c022a:  AC_Bookmarks (Favorites)
  USB_KEYMAP(0x0c022a, 0x009c, 0x00a4, 0xe066, 0xffff, "BrowserFavorites",
             BROWSER_FAVORITES),
  USB_KEYMAP(0x0c022d, 0x01a2, 0x01aa, 0x0000, 0xffff, NULL, ZOOM_IN),
  USB_KEYMAP(0x0c022e, 0x01a3, 0x01ab, 0x0000, 0xffff, NULL, ZOOM_OUT),
  // USB#0x0c0230:  AC Full Screen View
  //USB_KEYMAP(0x0c0230, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ZOOM_FULL),
  // USB#0x0c0231:  AC Normal View
  //USB_KEYMAP(0x0c0231, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ZOOM_NORMAL),
  // USB#0x0c0232:  AC View Toggle
  USB_KEYMAP(0x0c0232, 0x0000, 0x0000, 0x0000, 0xffff, "ZoomToggle", ZOOM_TOGGLE),
  // USB#0x0c0279:  AC Redo/Repeat
  USB_KEYMAP(0x0c0279, 0x00b6, 0x00be, 0x0000, 0xffff, NULL, REDO),
  // USB#0x0c0289:  AC_Reply
  USB_KEYMAP(0x0c0289, 0x00e8, 0x00f0, 0x0000, 0xffff, "MailReply", MAIL_REPLY),
  // USB#0x0c028b:  AC_ForwardMsg (MailForward)
  USB_KEYMAP(0x0c028b, 0x00e9, 0x00f1, 0x0000, 0xffff, "MailForward", MAIL_FORWARD),
  // USB#0x0c028c:  AC_Send
  USB_KEYMAP(0x0c028c, 0x00e7, 0x00ef, 0x0000, 0xffff, "MailSend", MAIL_SEND),
};

 Raw log
 worker_info
Worker information

hostname: production-4-worker-org-c-5-gce:e3d35907-6f5e-4190-afe7-e978d31d4fd9

version: v2.9.3 https://github.com/travis-ci/worker/tree/a41c772c638071fbbdbc106f31a664c0532e0c36

instance: testing-gce-6f9208f4-da28-450f-8b8b-f0d5434a2d94:travis-ci-nodejs-precise-1491943444 (via amqp)

startup: 21.321889554s

system_info
Build system information

Build language: node_js

Build group: stable

Build dist: precise

Build id: 252070272

Job id: 252070275

travis-build version: 6094b6ae8

Build image provisioning date and time

Tue Apr 11 21:39:22 UTC 2017

Operating System Details

Distributor ID:	Ubuntu

Description:	Ubuntu 12.04.5 LTS

Release:	12.04

Codename:	precise

Linux Version

3.13.0-115-generic

Cookbooks Version

cc4eb5e https://github.com/travis-ci/travis-cookbooks/tree/cc4eb5e

Git version

git version 1.8.5.6

bash version

GNU bash, version 4.2.25(1)-release (x86_64-pc-linux-gnu)

Copyright (C) 2011 Free Software Foundation, Inc.

License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>


This is free software; you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.

GCC version

gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

Copyright (C) 2011 Free Software Foundation, Inc.

This is free software; see the source for copying conditions.  There is NO

warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


LLVM version

clang version 3.4 (tags/RELEASE_34/final)

Target: x86_64-unknown-linux-gnu

Thread model: posix

Pre-installed Ruby versions

ruby-2.2.6

Pre-installed Node.js versions

iojs-v1.1.0

v0.10

v0.10.18

v0.10.36

v0.11.15

v0.6.21

v0.8.27

Pre-installed Go versions

1.7.4

mysql --version

mysql  Ver 14.14 Distrib 5.5.54, for debian-linux-gnu (x86_64) using readline 6.2

Pre-installed PostgreSQL versions

9.1.24

9.2.20

9.3.16

9.4.11

9.5.6

Redis version

redis-server 3.0.7

riak version

2.0.2

memcached version

1.4.13

MongoDB version

MongoDB 2.4.14

CouchDB version

couchdb 1.6.1

Installed Sphinx versions

2.0.10

2.1.9

2.2.6

Default Sphinx version

2.2.6

Installed Firefox version

firefox 38.4.0esr

PhantomJS version

1.9.8

ant -version

Apache Ant(TM) version 1.8.2 compiled on December 3 2011

mvn -version

Apache Maven 3.2.5 (12a6b3acb947671f09b81f49094c53f426d8cea1; 2014-12-14T17:29:23+00:00)

Maven home: /usr/local/maven

Java version: 1.7.0_80, vendor: Oracle Corporation

Java home: /usr/lib/jvm/java-7-oracle/jre

Default locale: en, platform encoding: UTF-8

OS name: "linux", version: "3.13.0-115-generic", arch: "amd64", family: "unix"


W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise-updates/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise-backports/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise/Release.gpg: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://security.ubuntu.com/ubuntu/dists/precise-security/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://downloads-distro.mongodb.org/repo/debian-sysvinit/dists/dist/Release.gpg: Signature by key 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10 uses weak digest algorithm (SHA1)

W: http://ppa.launchpad.net/couchdb/stable/ubuntu/dists/precise/Release.gpg: Signature by key 15866BAFD9BCC4F3C1E0DFC7D69548E1C17EAB57 uses weak digest algorithm (SHA1)

W: http://ppa.launchpad.net/git-core/v1.8/ubuntu/dists/precise/Release.gpg: Signature by key E1DD270288B4E6030699E45FA1715D88E1DF1F24 uses weak digest algorithm (SHA1)

git.checkout
0.70s$ git clone --depth=1 --branch=master https://github.com/atom/keyboard-layout.git atom/keyboard-layout

Cloning into 'atom/keyboard-layout'...

remote: Counting objects: 22, done.

remote: Compressing objects: 100% (20/20), done.

remote: Total 22 (delta 0), reused 9 (delta 0), pack-reused 0

Unpacking objects: 100% (22/22), done.

Checking connectivity... done.


$ cd atom/keyboard-layout

$ git checkout -qf b8b93241fc7578481588b9495d4464dd7fb4b98e

apt
Installing APT Packages (BETA)

$ export DEBIAN_FRONTEND=noninteractive

2.31s$ sudo -E apt-get -yq update &>> ~/apt-get-update.log


5.46s$ sudo -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install clang-3.3 libx11-dev libxkbfile-dev

Reading package lists...

Building dependency tree...

Reading state information...

libx11-dev is already the newest version (2:1.4.99.1-0ubuntu2.3).

libx11-dev set to manually installed.

The following additional packages will be installed:

  libclang-common-3.3-dev libclang1-3.3 libllvm3.3

Recommended packages:

  llvm-3.3-dev

The following NEW packages will be installed:

  clang-3.3 libclang-common-3.3-dev libclang1-3.3 libllvm3.3 libxkbfile-dev

0 upgraded, 5 newly installed, 0 to remove and 41 not upgraded.

Need to get 25.9 MB of archives.

After this operation, 70.0 MB of additional disk space will be used.

Get:1 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libllvm3.3 amd64 1:3.3-5ubuntu4~precise1 [9,040 kB]

Get:2 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libclang-common-3.3-dev amd64 1:3.3-5ubuntu4~precise1 [573 kB]

Get:3 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libclang1-3.3 amd64 1:3.3-5ubuntu4~precise1 [4,837 kB]

Get:4 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/universe amd64 clang-3.3 amd64 1:3.3-5ubuntu4~precise1 [11.4 MB]

Get:5 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libxkbfile-dev amd64 1:1.0.7-1ubuntu0.1 [88.9 kB]

Fetched 25.9 MB in 1s (14.8 MB/s)

Selecting previously unselected package libllvm3.3.

(Reading database ... 75245 files and directories currently installed.)

Unpacking libllvm3.3 (from .../libllvm3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libclang-common-3.3-dev.

Unpacking libclang-common-3.3-dev (from .../libclang-common-3.3-dev_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libclang1-3.3.

Unpacking libclang1-3.3 (from .../libclang1-3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package clang-3.3.

Unpacking clang-3.3 (from .../clang-3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libxkbfile-dev.

Unpacking libxkbfile-dev (from .../libxkbfile-dev_1%3a1.0.7-1ubuntu0.1_amd64.deb) ...

Processing triggers for man-db ...

Setting up libllvm3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up libclang-common-3.3-dev (1:3.3-5ubuntu4~precise1) ...

Setting up libclang1-3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up clang-3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up libxkbfile-dev (1:1.0.7-1ubuntu0.1) ...

Processing triggers for libc-bin ...

ldconfig deferred processing now taking place

W: --force-yes is deprecated, use one of the options starting with --allow instead.



Setting environment variables from .travis.yml

$ export DISPLAY=:99.0

$ export CC=clang

$ export CXX=clang++

$ export npm_config_clang=1


Updating nvm

nvm.install
3.00s$ nvm install 6

Downloading and installing node v6.11.0...

Downloading https://nodejs.org/dist/v6.11.0/node-v6.11.0-linux-x64.tar.xz...

######################################################################## 100.0%

Computing checksum with sha256sum

Checksums matched!

Now using node v6.11.0 (npm v3.10.10)


$ node --version

v6.11.0

$ npm --version

3.10.10

$ nvm --version

0.33.2

before_install
0.01s$ /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16


install.npm
5.88s$ npm install 

npm WARN deprecated minimatch@0.2.14: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN deprecated minimatch@0.4.0: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN deprecated minimatch@0.3.0: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN prefer global jasmine-node@1.10.2 should be installed with -g


> keyboard-layout@2.0.13 install /home/travis/build/atom/keyboard-layout

> node-gyp rebuild


gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

make: Entering directory `/home/travis/build/atom/keyboard-layout/build'

  CXX(target) Release/obj.target/keyboard-layout-manager/src/keyboard-layout-manager-linux.o

  SOLINK_MODULE(target) Release/obj.target/keyboard-layout-manager.node

  COPY Release/keyboard-layout-manager.node

make: Leaving directory `/home/travis/build/atom/keyboard-layout/build'

keyboard-layout@2.0.13 /home/travis/build/atom/keyboard-layout

├── event-kit@2.3.0 

├─┬ jasmine-focused@1.0.7 

│ ├─┬ jasmine-node@1.10.2  (git+https://github.com/kevinsawicki/jasmine-node.git#81af4f953a2b7dfb5bde8331c05362a4b464c5ef)

│ │ ├── coffee-script@1.12.6 

│ │ ├─┬ coffeestack@1.1.2 

│ │ │ ├── coffee-script@1.8.0 

│ │ │ ├─┬ fs-plus@2.10.1 

│ │ │ │ ├── async@1.5.2 

│ │ │ │ ├── mkdirp@0.5.1 

│ │ │ │ └─┬ rimraf@2.6.1 

│ │ │ │   └─┬ glob@7.1.2 

│ │ │ │     ├── fs.realpath@1.0.0 

│ │ │ │     ├─┬ inflight@1.0.6 

│ │ │ │     │ └── wrappy@1.0.2 

│ │ │ │     ├─┬ minimatch@3.0.4 

│ │ │ │     │ └─┬ brace-expansion@1.1.8 

│ │ │ │     │   ├── balanced-match@1.0.0 

│ │ │ │     │   └── concat-map@0.0.1 

│ │ │ │     ├── once@1.4.0 

│ │ │ │     └── path-is-absolute@1.0.1 

│ │ │ └─┬ source-map@0.1.43 

│ │ │   └── amdefine@1.0.1 

│ │ ├─┬ gaze@0.3.4 

│ │ │ ├─┬ fileset@0.1.8 

│ │ │ │ ├─┬ glob@3.2.11 

│ │ │ │ │ ├── inherits@2.0.3 

│ │ │ │ │ └── minimatch@0.3.0 

│ │ │ │ └── minimatch@0.4.0 

│ │ │ └─┬ minimatch@0.2.14 

│ │ │   ├── lru-cache@2.7.3 

│ │ │   └── sigmund@1.0.1 

│ │ ├─┬ jasmine-reporters@2.2.1 

│ │ │ ├─┬ mkdirp@0.5.1 

│ │ │ │ └── minimist@0.0.8 

│ │ │ └── xmldom@0.1.27 

│ │ ├── mkdirp@0.3.5 

│ │ ├── requirejs@2.3.3 

│ │ └── underscore@1.8.3 

│ ├─┬ underscore-plus@1.6.6 

│ │ └── underscore@1.6.0 

│ └── walkdir@0.0.7 

└── nan@2.6.2 


npm WARN keyboard-layout@2.0.13 No license field.


0.80s$ npm test


> keyboard-layout@2.0.13 test /home/travis/build/atom/keyboard-layout

> jasmine-focused --captureExceptions --forceexit spec


..


Finished in 0.009 seconds

2 tests, 3 assertions, 0 failures, 0 skipped





The command "npm test" exited with 0.


Done. Your build exited with 0.
578 lines (530 sloc)  33.7 KB
// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file has no header guard because it is explicily intended
// to be included more than once with different definitions of the
// macros USB_KEYMAP and USB_KEYMAP_DECLARATION.

// Data in this file was created by referencing:
//  [0] USB HID Usage Tables,
//      http://www.usb.org/developers/hidpage/Hut1_12v2.pdf
//  [1] DOM Level 3 KeyboardEvent code Values,
//      http://www.w3.org/TR/uievents-code/
//  [2] OS X <HIToolbox/Events.h>
//  [3] Linux <linux/input.h> and hid-input.c
//  [4] USB HID to PS/2 Scan Code Translation Table
//      http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
//  [5] Keyboard Scan Code Specification
//      http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/scancode.doc

// General notes:
//
//  This table provides the definition of ui::DomCode (UI Events |code|) values
//  as well as mapping between scan codes and DomCode. Some entries have no
//  defined scan codes; these are present only to allow those UI Events |code|
//  strings to be represented by DomCode. A few have a null code; these define
//  mappings with a DomCode:: value but no |code| string, typically because
//  they end up used in shortcuts but not standardized in UI Events; e.g.
//  DomCode::BRIGHTNESS_UP. Commented-out entries document USB codes that are
//  potentially interesting but not currently used.

// Linux notes:
//
//  All USB codes that are listed here and that are supported by the kernel
//  (as of 4.2) have their evdev/xkb scan codes recorded; if an evdev/xkb
//  code is 0, it is because the kernel USB driver does not handle that key.
//
//  Some Linux kernel mappings for USB keys may seem counterintuitive:
//
//  [L1] Although evdev 0x163 KEY_CLEAR exists, Linux does not use it
//       for any USB keys. Linux maps USB 0x07009c [Keyboard Clear] and
//       0x0700d8 [Keypad Clear] to KEY_DELETE "Delete", so those codes are
//       not distinguishable by applications, and UI Events "NumpadClear"
//       is therefore not supported. USB 0x0700A2 [Keyboard Clear/Again]
//       is not mapped by the kernel at all.
//
//  [L2] 'Menu' and 'Props' naming differs between evdev and USB / UI Events.
//        USB 0x010085 [System Main Menu] and USB 0x0C0040 [Menu Mode] both
//        map to evdev 0x8B KEY_MENU (which has no corresponding UI Events
//        |code|). USB 0x070076 [Keyboard Menu] does not map to KEY_MENU;
//        it maps to evdev 0x82 KEY_PROPS, which is not the same as USB and
//        UI Events "Props". USB 0x0700A3 [Props], which does correspond to
//        UI Events "Props", is not mapped by the kernel. (And all of these
//        are distinct from UI Events' "ContextMenu", which corresponds to
//        USB 0x070065 [Keyboard Application] via evdev 0x7F KEY_COMPOSE,
//        following Windows convention.)
//
//  [L3]  Linux flattens both USB 0x070048 [Keyboard Pause] and 0x0C00B1
//        [Media Pause] to 0x77 KEY_PAUSE. We map the former, since [1]
//        defines a 'Pause' code but no 'MediaPause' code.

// Windows notes:
//
//  The set of scan codes supported here may not be complete.
//
//  [W1] Windows maps both USB 0x070094 [Lang5] and USB 0x070073 [F24] to the
//       same scan code, 0x76. (Microsoft's defined scan codes for F13 - F24
//       appear to be the result of accidentally mapping an IBM Set 3 terminal
//       keyboard, rather than an IBM Set 2 PC keyboard, through the BIOS
//       2-to-1 table.)  We map 0x76 to F24 here, since Lang5 appears unused
//       in practice (its declared function, Zenkaku/Hankaku switch, is
//       conventionally placed on Backquote by Japanese keyboards).

// Macintosh notes:
//
//  The set of scan codes supported here may not be complete.
//
//  [M1] OS X maps USB 0x070049 [Insert] as well as USB 0x070075 [Help] to
//       scan code 0x72 kVK_Help. We map this to UI Events 'Insert', since
//       Apple keyboards with USB 0x070049 [Insert] labelled "Help" have not
//       been made since 2007.

USB_KEYMAP_DECLARATION {

  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x000000, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NONE), // Invalid

  // =========================================
  // Non-USB codes
  // =========================================

  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x000010, 0x0000, 0x0000, 0x0000, 0xffff, "Hyper", HYPER),
  USB_KEYMAP(0x000011, 0x0000, 0x0000, 0x0000, 0xffff, "Super", SUPER),
  USB_KEYMAP(0x000012, 0x0000, 0x0000, 0x0000, 0xffff, "Fn", FN),
  USB_KEYMAP(0x000013, 0x0000, 0x0000, 0x0000, 0xffff, "FnLock", FN_LOCK),
  USB_KEYMAP(0x000014, 0x0000, 0x0000, 0x0000, 0xffff, "Suspend", SUSPEND),
  USB_KEYMAP(0x000015, 0x0000, 0x0000, 0x0000, 0xffff, "Resume", RESUME),
  USB_KEYMAP(0x000016, 0x0000, 0x0000, 0x0000, 0xffff, "Turbo", TURBO),

  // =========================================
  // USB Usage Page 0x01: Generic Desktop Page
  // =========================================

  // Sleep could be encoded as USB#0c0032, but there's no corresponding WakeUp
  // in the 0x0c USB page.
  //            USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x010082, 0x008e, 0x0096, 0xe05f, 0xffff, "Sleep", SLEEP), // SystemSleep
  USB_KEYMAP(0x010083, 0x008f, 0x0097, 0xe063, 0xffff, "WakeUp", WAKE_UP),

  // =========================================
  // USB Usage Page 0x07: Keyboard/Keypad Page
  // =========================================

  // TODO(garykac):
  // XKB#005c ISO Level3 Shift (AltGr)
  // XKB#005e <>||
  // XKB#006d Linefeed
  // XKB#008a SunProps cf. USB#0700a3 CrSel/Props
  // XKB#008e SunOpen
  // Mac#003f kVK_Function
  // Mac#000a kVK_ISO_Section (ISO keyboards only)
  // Mac#0066 kVK_JIS_Eisu (USB#07008a Henkan?)

  //            USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x070000, 0x0000, 0x0000, 0x0000, 0xffff, NULL, USB_RESERVED),
  USB_KEYMAP(0x070001, 0x0000, 0x0000, 0x00ff, 0xffff, NULL, USB_ERROR_ROLL_OVER),
  USB_KEYMAP(0x070002, 0x0000, 0x0000, 0x00fc, 0xffff, NULL, USB_POST_FAIL),
  USB_KEYMAP(0x070003, 0x0000, 0x0000, 0x0000, 0xffff, NULL, USB_ERROR_UNDEFINED),
  USB_KEYMAP(0x070004, 0x001e, 0x0026, 0x001e, 0x0000, "KeyA", US_A), // aA
  USB_KEYMAP(0x070005, 0x0030, 0x0038, 0x0030, 0x000b, "KeyB", US_B), // bB
  USB_KEYMAP(0x070006, 0x002e, 0x0036, 0x002e, 0x0008, "KeyC", US_C), // cC
  USB_KEYMAP(0x070007, 0x0020, 0x0028, 0x0020, 0x0002, "KeyD", US_D), // dD

  USB_KEYMAP(0x070008, 0x0012, 0x001a, 0x0012, 0x000e, "KeyE", US_E), // eE
  USB_KEYMAP(0x070009, 0x0021, 0x0029, 0x0021, 0x0003, "KeyF", US_F), // fF
  USB_KEYMAP(0x07000a, 0x0022, 0x002a, 0x0022, 0x0005, "KeyG", US_G), // gG
  USB_KEYMAP(0x07000b, 0x0023, 0x002b, 0x0023, 0x0004, "KeyH", US_H), // hH
  USB_KEYMAP(0x07000c, 0x0017, 0x001f, 0x0017, 0x0022, "KeyI", US_I), // iI
  USB_KEYMAP(0x07000d, 0x0024, 0x002c, 0x0024, 0x0026, "KeyJ", US_J), // jJ
  USB_KEYMAP(0x07000e, 0x0025, 0x002d, 0x0025, 0x0028, "KeyK", US_K), // kK
  USB_KEYMAP(0x07000f, 0x0026, 0x002e, 0x0026, 0x0025, "KeyL", US_L), // lL

  USB_KEYMAP(0x070010, 0x0032, 0x003a, 0x0032, 0x002e, "KeyM", US_M), // mM
  USB_KEYMAP(0x070011, 0x0031, 0x0039, 0x0031, 0x002d, "KeyN", US_N), // nN
  USB_KEYMAP(0x070012, 0x0018, 0x0020, 0x0018, 0x001f, "KeyO", US_O), // oO
  USB_KEYMAP(0x070013, 0x0019, 0x0021, 0x0019, 0x0023, "KeyP", US_P), // pP
  USB_KEYMAP(0x070014, 0x0010, 0x0018, 0x0010, 0x000c, "KeyQ", US_Q), // qQ
  USB_KEYMAP(0x070015, 0x0013, 0x001b, 0x0013, 0x000f, "KeyR", US_R), // rR
  USB_KEYMAP(0x070016, 0x001f, 0x0027, 0x001f, 0x0001, "KeyS", US_S), // sS
  USB_KEYMAP(0x070017, 0x0014, 0x001c, 0x0014, 0x0011, "KeyT", US_T), // tT

  USB_KEYMAP(0x070018, 0x0016, 0x001e, 0x0016, 0x0020, "KeyU", US_U), // uU
  USB_KEYMAP(0x070019, 0x002f, 0x0037, 0x002f, 0x0009, "KeyV", US_V), // vV
  USB_KEYMAP(0x07001a, 0x0011, 0x0019, 0x0011, 0x000d, "KeyW", US_W), // wW
  USB_KEYMAP(0x07001b, 0x002d, 0x0035, 0x002d, 0x0007, "KeyX", US_X), // xX
  USB_KEYMAP(0x07001c, 0x0015, 0x001d, 0x0015, 0x0010, "KeyY", US_Y), // yY
  USB_KEYMAP(0x07001d, 0x002c, 0x0034, 0x002c, 0x0006, "KeyZ", US_Z), // zZ
  USB_KEYMAP(0x07001e, 0x0002, 0x000a, 0x0002, 0x0012, "Digit1", DIGIT1), // 1!
  USB_KEYMAP(0x07001f, 0x0003, 0x000b, 0x0003, 0x0013, "Digit2", DIGIT2), // 2@

  USB_KEYMAP(0x070020, 0x0004, 0x000c, 0x0004, 0x0014, "Digit3", DIGIT3), // 3#
  USB_KEYMAP(0x070021, 0x0005, 0x000d, 0x0005, 0x0015, "Digit4", DIGIT4), // 4$
  USB_KEYMAP(0x070022, 0x0006, 0x000e, 0x0006, 0x0017, "Digit5", DIGIT5), // 5%
  USB_KEYMAP(0x070023, 0x0007, 0x000f, 0x0007, 0x0016, "Digit6", DIGIT6), // 6^
  USB_KEYMAP(0x070024, 0x0008, 0x0010, 0x0008, 0x001a, "Digit7", DIGIT7), // 7&
  USB_KEYMAP(0x070025, 0x0009, 0x0011, 0x0009, 0x001c, "Digit8", DIGIT8), // 8*
  USB_KEYMAP(0x070026, 0x000a, 0x0012, 0x000a, 0x0019, "Digit9", DIGIT9), // 9(
  USB_KEYMAP(0x070027, 0x000b, 0x0013, 0x000b, 0x001d, "Digit0", DIGIT0), // 0)

  USB_KEYMAP(0x070028, 0x001c, 0x0024, 0x001c, 0x0024, "Enter", ENTER),
  USB_KEYMAP(0x070029, 0x0001, 0x0009, 0x0001, 0x0035, "Escape", ESCAPE),
  USB_KEYMAP(0x07002a, 0x000e, 0x0016, 0x000e, 0x0033, "Backspace", BACKSPACE),
  USB_KEYMAP(0x07002b, 0x000f, 0x0017, 0x000f, 0x0030, "Tab", TAB),
  USB_KEYMAP(0x07002c, 0x0039, 0x0041, 0x0039, 0x0031, "Space", SPACE), // Spacebar
  USB_KEYMAP(0x07002d, 0x000c, 0x0014, 0x000c, 0x001b, "Minus", MINUS), // -_
  USB_KEYMAP(0x07002e, 0x000d, 0x0015, 0x000d, 0x0018, "Equal", EQUAL), // =+
  USB_KEYMAP(0x07002f, 0x001a, 0x0022, 0x001a, 0x0021, "BracketLeft", BRACKET_LEFT),

  USB_KEYMAP(0x070030, 0x001b, 0x0023, 0x001b, 0x001e, "BracketRight", BRACKET_RIGHT),
  USB_KEYMAP(0x070031, 0x002b, 0x0033, 0x002b, 0x002a, "Backslash", BACKSLASH), // \|
  // USB#070032 never appears on keyboards that have USB#070031.
  // Platforms use the same scancode as for the two keys.
  // Hence this code can only be generated synthetically
  // (e.g. in a DOM Level 3 KeyboardEvent).
  // The keycap varies on international keyboards:
  //   Dan: '*  Dutch: <>  Ger: #'  UK: #~
  // TODO(garykac): Verify Mac intl keyboard.
  USB_KEYMAP(0x070032, 0x0000, 0x0000, 0x0000, 0xffff, "IntlHash", INTL_HASH),
  USB_KEYMAP(0x070033, 0x0027, 0x002f, 0x0027, 0x0029, "Semicolon", SEMICOLON), // ;:
  USB_KEYMAP(0x070034, 0x0028, 0x0030, 0x0028, 0x0027, "Quote", QUOTE), // '"
  USB_KEYMAP(0x070035, 0x0029, 0x0031, 0x0029, 0x0032, "Backquote", BACKQUOTE), // `~
  USB_KEYMAP(0x070036, 0x0033, 0x003b, 0x0033, 0x002b, "Comma", COMMA), // ,<
  USB_KEYMAP(0x070037, 0x0034, 0x003c, 0x0034, 0x002f, "Period", PERIOD), // .>

  USB_KEYMAP(0x070038, 0x0035, 0x003d, 0x0035, 0x002c, "Slash", SLASH), // /?
  // TODO(garykac): CapsLock requires special handling for each platform.
  USB_KEYMAP(0x070039, 0x003a, 0x0042, 0x003a, 0x0039, "CapsLock", CAPS_LOCK),
  USB_KEYMAP(0x07003a, 0x003b, 0x0043, 0x003b, 0x007a, "F1", F1),
  USB_KEYMAP(0x07003b, 0x003c, 0x0044, 0x003c, 0x0078, "F2", F2),
  USB_KEYMAP(0x07003c, 0x003d, 0x0045, 0x003d, 0x0063, "F3", F3),
  USB_KEYMAP(0x07003d, 0x003e, 0x0046, 0x003e, 0x0076, "F4", F4),
  USB_KEYMAP(0x07003e, 0x003f, 0x0047, 0x003f, 0x0060, "F5", F5),
  USB_KEYMAP(0x07003f, 0x0040, 0x0048, 0x0040, 0x0061, "F6", F6),

  USB_KEYMAP(0x070040, 0x0041, 0x0049, 0x0041, 0x0062, "F7", F7),
  USB_KEYMAP(0x070041, 0x0042, 0x004a, 0x0042, 0x0064, "F8", F8),
  USB_KEYMAP(0x070042, 0x0043, 0x004b, 0x0043, 0x0065, "F9", F9),
  USB_KEYMAP(0x070043, 0x0044, 0x004c, 0x0044, 0x006d, "F10", F10),
  USB_KEYMAP(0x070044, 0x0057, 0x005f, 0x0057, 0x0067, "F11", F11),
  USB_KEYMAP(0x070045, 0x0058, 0x0060, 0x0058, 0x006f, "F12", F12),
  // PrintScreen is effectively F13 on Mac OS X.
  USB_KEYMAP(0x070046, 0x0063, 0x006b, 0xe037, 0xffff, "PrintScreen", PRINT_SCREEN),
  USB_KEYMAP(0x070047, 0x0046, 0x004e, 0x0046, 0xffff, "ScrollLock", SCROLL_LOCK),

  USB_KEYMAP(0x070048, 0x0077, 0x007f, 0x0045, 0xffff, "Pause", PAUSE),
  // USB#0x070049 Insert, labeled "Help/Insert" on Mac -- see note M1 at top.
  USB_KEYMAP(0x070049, 0x006e, 0x0076, 0xe052, 0x0072, "Insert", INSERT),
  USB_KEYMAP(0x07004a, 0x0066, 0x006e, 0xe047, 0x0073, "Home", HOME),
  USB_KEYMAP(0x07004b, 0x0068, 0x0070, 0xe049, 0x0074, "PageUp", PAGE_UP),
  // Delete (Forward Delete) named DEL because DELETE conflicts with <windows.h>
  USB_KEYMAP(0x07004c, 0x006f, 0x0077, 0xe053, 0x0075, "Delete", DEL),
  USB_KEYMAP(0x07004d, 0x006b, 0x0073, 0xe04f, 0x0077, "End", END),
  USB_KEYMAP(0x07004e, 0x006d, 0x0075, 0xe051, 0x0079, "PageDown", PAGE_DOWN),
  USB_KEYMAP(0x07004f, 0x006a, 0x0072, 0xe04d, 0x007c, "ArrowRight", ARROW_RIGHT),

  USB_KEYMAP(0x070050, 0x0069, 0x0071, 0xe04b, 0x007b, "ArrowLeft", ARROW_LEFT),
  USB_KEYMAP(0x070051, 0x006c, 0x0074, 0xe050, 0x007d, "ArrowDown", ARROW_DOWN),
  USB_KEYMAP(0x070052, 0x0067, 0x006f, 0xe048, 0x007e, "ArrowUp", ARROW_UP),
  USB_KEYMAP(0x070053, 0x0045, 0x004d, 0xe045, 0x0047, "NumLock", NUM_LOCK),
  USB_KEYMAP(0x070054, 0x0062, 0x006a, 0xe035, 0x004b, "NumpadDivide", NUMPAD_DIVIDE),
  USB_KEYMAP(0x070055, 0x0037, 0x003f, 0x0037, 0x0043, "NumpadMultiply",
             NUMPAD_MULTIPLY),  // Keypad_*
  USB_KEYMAP(0x070056, 0x004a, 0x0052, 0x004a, 0x004e, "NumpadSubtract",
             NUMPAD_SUBTRACT),  // Keypad_-
  USB_KEYMAP(0x070057, 0x004e, 0x0056, 0x004e, 0x0045, "NumpadAdd", NUMPAD_ADD),

  USB_KEYMAP(0x070058, 0x0060, 0x0068, 0xe01c, 0x004c, "NumpadEnter", NUMPAD_ENTER),
  USB_KEYMAP(0x070059, 0x004f, 0x0057, 0x004f, 0x0053, "Numpad1", NUMPAD1), // +End
  USB_KEYMAP(0x07005a, 0x0050, 0x0058, 0x0050, 0x0054, "Numpad2", NUMPAD2), // +Down
  USB_KEYMAP(0x07005b, 0x0051, 0x0059, 0x0051, 0x0055, "Numpad3", NUMPAD3), // +PageDn
  USB_KEYMAP(0x07005c, 0x004b, 0x0053, 0x004b, 0x0056, "Numpad4", NUMPAD4), // +Left
  USB_KEYMAP(0x07005d, 0x004c, 0x0054, 0x004c, 0x0057, "Numpad5", NUMPAD5), //
  USB_KEYMAP(0x07005e, 0x004d, 0x0055, 0x004d, 0x0058, "Numpad6", NUMPAD6), // +Right
  USB_KEYMAP(0x07005f, 0x0047, 0x004f, 0x0047, 0x0059, "Numpad7", NUMPAD7), // +Home

  USB_KEYMAP(0x070060, 0x0048, 0x0050, 0x0048, 0x005b, "Numpad8", NUMPAD8), // +Up
  USB_KEYMAP(0x070061, 0x0049, 0x0051, 0x0049, 0x005c, "Numpad9", NUMPAD9), // +PageUp
  USB_KEYMAP(0x070062, 0x0052, 0x005a, 0x0052, 0x0052, "Numpad0", NUMPAD0), // +Insert
  USB_KEYMAP(0x070063, 0x0053, 0x005b, 0x0053, 0x0041, "NumpadDecimal",
             NUMPAD_DECIMAL),  // Keypad_. Delete
  // USB#070064 is not present on US keyboard.
  // This key is typically located near LeftShift key.
  // The keycap varies on international keyboards:
  //   Dan: <> Dutch: ][ Ger: <> UK: \|
  USB_KEYMAP(0x070064, 0x0056, 0x005e, 0x0056, 0x000a, "IntlBackslash", INTL_BACKSLASH),
  // USB#0x070065 Application Menu (next to RWin key) -- see note L2 at top.
  USB_KEYMAP(0x070065, 0x007f, 0x0087, 0xe05d, 0x006e, "ContextMenu", CONTEXT_MENU),
  USB_KEYMAP(0x070066, 0x0074, 0x007c, 0xe05e, 0xffff, "Power", POWER),
  USB_KEYMAP(0x070067, 0x0075, 0x007d, 0x0059, 0x0051, "NumpadEqual", NUMPAD_EQUAL),

  USB_KEYMAP(0x070068, 0x00b7, 0x00bf, 0x0064, 0x0069, "F13", F13),
  USB_KEYMAP(0x070069, 0x00b8, 0x00c0, 0x0065, 0x006b, "F14", F14),
  USB_KEYMAP(0x07006a, 0x00b9, 0x00c1, 0x0066, 0x0071, "F15", F15),
  USB_KEYMAP(0x07006b, 0x00ba, 0x00c2, 0x0067, 0x006a, "F16", F16),
  USB_KEYMAP(0x07006c, 0x00bb, 0x00c3, 0x0068, 0x0040, "F17", F17),
  USB_KEYMAP(0x07006d, 0x00bc, 0x00c4, 0x0069, 0x004f, "F18", F18),
  USB_KEYMAP(0x07006e, 0x00bd, 0x00c5, 0x006a, 0x0050, "F19", F19),
  USB_KEYMAP(0x07006f, 0x00be, 0x00c6, 0x006b, 0x005a, "F20", F20),

  USB_KEYMAP(0x070070, 0x00bf, 0x00c7, 0x006c, 0xffff, "F21", F21),
  USB_KEYMAP(0x070071, 0x00c0, 0x00c8, 0x006d, 0xffff, "F22", F22),
  USB_KEYMAP(0x070072, 0x00c1, 0x00c9, 0x006e, 0xffff, "F23", F23),
  // USB#0x070073 -- see note W1 at top.
  USB_KEYMAP(0x070073, 0x00c2, 0x00ca, 0x0076, 0xffff, "F24", F24),
  USB_KEYMAP(0x070074, 0x0086, 0x008e, 0x0000, 0xffff, "Open", OPEN), // Execute
  // USB#0x070075 Help -- see note M1 at top.
  USB_KEYMAP(0x070075, 0x008a, 0x0092, 0xe03b, 0xffff, "Help", HELP),
  // USB#0x070076 Keyboard Menu -- see note L2 at top.
  //USB_KEYMAP(0x070076, 0x0000, 0x0000, 0x0000, 0xffff, NULL, MENU), // Menu
  USB_KEYMAP(0x070077, 0x0084, 0x008c, 0x0000, 0xffff, "Select", SELECT), // Select

  //USB_KEYMAP(0x070078, 0x0080, 0x0088, 0x0000, 0xffff, NULL, STOP), // Stop
  USB_KEYMAP(0x070079, 0x0081, 0x0089, 0x0000, 0xffff, "Again", AGAIN), // Again
  USB_KEYMAP(0x07007a, 0x0083, 0x008b, 0xe008, 0xffff, "Undo", UNDO),
  USB_KEYMAP(0x07007b, 0x0089, 0x0091, 0xe017, 0xffff, "Cut", CUT),
  USB_KEYMAP(0x07007c, 0x0085, 0x008d, 0xe018, 0xffff, "Copy", COPY),
  USB_KEYMAP(0x07007d, 0x0087, 0x008f, 0xe00a, 0xffff, "Paste", PASTE),
  USB_KEYMAP(0x07007e, 0x0088, 0x0090, 0x0000, 0xffff, "Find", FIND), // Find
  USB_KEYMAP(0x07007f, 0x0071, 0x0079, 0xe020, 0x004a, "AudioVolumeMute", VOLUME_MUTE),

  USB_KEYMAP(0x070080, 0x0073, 0x007b, 0xe030, 0x0048, "AudioVolumeUp", VOLUME_UP),
  USB_KEYMAP(0x070081, 0x0072, 0x007a, 0xe02e, 0x0049, "AudioVolumeDown", VOLUME_DOWN),
  //USB_KEYMAP(0x070082, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_CAPS_LOCK),
  //USB_KEYMAP(0x070083, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_NUM_LOCK),
  //USB_KEYMAP(0x070084, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LOCKING_SCROLL_LOCK),
  USB_KEYMAP(0x070085, 0x0079, 0x0081, 0x007e, 0x005f, "NumpadComma", NUMPAD_COMMA),

  // International1
  // USB#070086 is used on AS/400 keyboards. Standard Keypad_= is USB#070067.
  //USB_KEYMAP(0x070086, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_EQUAL),
  // USB#070087 is used for Brazilian /? and Japanese _ 'ro'.
  USB_KEYMAP(0x070087, 0x0059, 0x0061, 0x0073, 0x005e, "IntlRo", INTL_RO),
  // International2
  // USB#070088 is used as Japanese Hiragana/Katakana key.
  USB_KEYMAP(0x070088, 0x005d, 0x0065, 0x0070, 0x0068, "KanaMode", KANA_MODE),
  // International3
  // USB#070089 is used as Japanese Yen key.
  USB_KEYMAP(0x070089, 0x007c, 0x0084, 0x007d, 0x005d, "IntlYen", INTL_YEN),
  // International4
  // USB#07008a is used as Japanese Henkan (Convert) key.
  USB_KEYMAP(0x07008a, 0x005c, 0x0064, 0x0079, 0xffff, "Convert", CONVERT),
  // International5
  // USB#07008b is used as Japanese Muhenkan (No-convert) key.
  USB_KEYMAP(0x07008b, 0x005e, 0x0066, 0x007b, 0xffff, "NonConvert", NON_CONVERT),
  //USB_KEYMAP(0x07008c, 0x005f, 0x0067, 0x005c, 0xffff, NULL, INTERNATIONAL6),
  //USB_KEYMAP(0x07008d, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL7),
  //USB_KEYMAP(0x07008e, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL8),
  //USB_KEYMAP(0x07008f, 0x0000, 0x0000, 0x0000, 0xffff, NULL, INTERNATIONAL9),

  // LANG1
  // USB#070090 is used as Korean Hangul/English toggle key.
  USB_KEYMAP(0x070090, 0x007a, 0x0082, 0x0072, 0xffff, "Lang1", LANG1),
  // LANG2
  // USB#070091 is used as Korean Hanja conversion key.
  USB_KEYMAP(0x070091, 0x007b, 0x0083, 0x0071, 0xffff, "Lang2", LANG2),
  // LANG3
  // USB#070092 is used as Japanese Katakana key.
  USB_KEYMAP(0x070092, 0x005a, 0x0062, 0x0078, 0xffff, "Lang3", LANG3),
  // LANG4
  // USB#070093 is used as Japanese Hiragana key.
  USB_KEYMAP(0x070093, 0x005b, 0x0063, 0x0077, 0xffff, "Lang4", LANG4),
  // LANG5
  // USB#070094 is used as Japanese Zenkaku/Hankaku (Fullwidth/halfwidth) key.
  // Not mapped on Windows -- see note W1 at top.
  USB_KEYMAP(0x070094, 0x0055, 0x005d, 0x0000, 0xffff, "Lang5", LANG5),
  //USB_KEYMAP(0x070095, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG6), // LANG6
  //USB_KEYMAP(0x070096, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG7), // LANG7
  //USB_KEYMAP(0x070097, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG8), // LANG8
  //USB_KEYMAP(0x070098, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LANG9), // LANG9

  //USB_KEYMAP(0x070099, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ALTERNATE_ERASE),
  //USB_KEYMAP(0x07009a, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SYS_REQ), // /Attention
  USB_KEYMAP(0x07009b, 0x0000, 0x0000, 0x0000, 0xffff, "Abort", ABORT), // Cancel
  // USB#0x07009c Keyboard Clear -- see note L1 at top.
  //USB_KEYMAP(0x07009c, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CLEAR), // Clear
  //USB_KEYMAP(0x07009d, 0x0000, 0x0000, 0x0000, 0xffff, NULL, PRIOR), // Prior
  //USB_KEYMAP(0x07009e, 0x0000, 0x0000, 0x0000, 0xffff, NULL, RETURN), // Return
  //USB_KEYMAP(0x07009f, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SEPARATOR), // Separator

  //USB_KEYMAP(0x0700a0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, OUT), // Out
  //USB_KEYMAP(0x0700a1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, OPER), // Oper
  //USB_KEYMAP(0x0700a2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CLEAR_AGAIN),
  // USB#0x0700a3 Props -- see note L2 at top.
  USB_KEYMAP(0x0700a3, 0x0000, 0x0000, 0x0000, 0xffff, "Props", PROPS), // CrSel/Props
  //USB_KEYMAP(0x0700a4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, EX_SEL), // ExSel

  //USB_KEYMAP(0x0700b0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_00),
  //USB_KEYMAP(0x0700b1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_000),
  //USB_KEYMAP(0x0700b2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, THOUSANDS_SEPARATOR),
  //USB_KEYMAP(0x0700b3, 0x0000, 0x0000, 0x0000, 0xffff, NULL, DECIMAL_SEPARATOR),
  //USB_KEYMAP(0x0700b4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CURRENCY_UNIT),
  //USB_KEYMAP(0x0700b5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, CURRENCY_SUBUNIT),
  USB_KEYMAP(0x0700b6, 0x00b3, 0x00bb, 0x0000, 0xffff, "NumpadParenLeft",
             NUMPAD_PAREN_LEFT),   // Keypad_(
  USB_KEYMAP(0x0700b7, 0x00b4, 0x00bc, 0x0000, 0xffff, "NumpadParenRight",
             NUMPAD_PAREN_RIGHT),  // Keypad_)

  //USB_KEYMAP(0x0700b8, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BRACE_LEFT),
  //USB_KEYMAP(0x0700b9, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BRACE_RIGHT),
  //USB_KEYMAP(0x0700ba, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_TAB),
  USB_KEYMAP(0x0700bb, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadBackspace",
             NUMPAD_BACKSPACE),  // Keypad_Backspace
  //USB_KEYMAP(0x0700bc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_A),
  //USB_KEYMAP(0x0700bd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_B),
  //USB_KEYMAP(0x0700be, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_C),
  //USB_KEYMAP(0x0700bf, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_D),

  //USB_KEYMAP(0x0700c0, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_E),
  //USB_KEYMAP(0x0700c1, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_F),
  //USB_KEYMAP(0x0700c2, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_XOR),
  //USB_KEYMAP(0x0700c3, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_CARAT),
  //USB_KEYMAP(0x0700c4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_PERCENT),
  //USB_KEYMAP(0x0700c5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_LESS_THAN),
  //USB_KEYMAP(0x0700c6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_GREATER_THAN),
  //USB_KEYMAP(0x0700c7, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_AMERSAND),

  //USB_KEYMAP(0x0700c8, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_DOUBLE_AMPERSAND),
  //USB_KEYMAP(0x0700c9, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_VERTICAL_BAR),
  //USB_KEYMAP(0x0700ca, 0x0000, 0x0000, 0x0000, 0xffff, NULL,
  //           NUMPAD_DOUBLE_VERTICAL_BAR),  // Keypad_||
  //USB_KEYMAP(0x0700cb, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_COLON),
  //USB_KEYMAP(0x0700cc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_NUMBER),
  //USB_KEYMAP(0x0700cd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_SPACE),
  //USB_KEYMAP(0x0700ce, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_AT),
  //USB_KEYMAP(0x0700cf, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_EXCLAMATION),

  USB_KEYMAP(0x0700d0, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryStore",
             NUMPAD_MEMORY_STORE),  // Keypad_MemoryStore
  USB_KEYMAP(0x0700d1, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryRecall",
             NUMPAD_MEMORY_RECALL),  // Keypad_MemoryRecall
  USB_KEYMAP(0x0700d2, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryClear",
             NUMPAD_MEMORY_CLEAR),  // Keypad_MemoryClear
  USB_KEYMAP(0x0700d3, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemoryAdd",
             NUMPAD_MEMORY_ADD),  // Keypad_MemoryAdd
  USB_KEYMAP(0x0700d4, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadMemorySubtract",
             NUMPAD_MEMORY_SUBTRACT),  // Keypad_MemorySubtract
  //USB_KEYMAP(0x0700d5, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_MEMORY_MULTIPLE),
  //USB_KEYMAP(0x0700d6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_MEMORY_DIVIDE),
  USB_KEYMAP(0x0700d7, 0x0076, 0x007e, 0x0000, 0xffff, NULL, NUMPAD_SIGN_CHANGE), // +/-
  // USB#0x0700d8 Keypad Clear -- see note L1 at top.
  USB_KEYMAP(0x0700d8, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadClear", NUMPAD_CLEAR),
  USB_KEYMAP(0x0700d9, 0x0000, 0x0000, 0x0000, 0xffff, "NumpadClearEntry",
             NUMPAD_CLEAR_ENTRY),  // Keypad_ClearEntry
  //USB_KEYMAP(0x0700da, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_BINARY),
  //USB_KEYMAP(0x0700db, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_OCTAL),
  //USB_KEYMAP(0x0700dc, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_DECIMAL),
  //USB_KEYMAP(0x0700dd, 0x0000, 0x0000, 0x0000, 0xffff, NULL, NUMPAD_HEXADECIMAL),

  // USB#0700de - #0700df are reserved.
  USB_KEYMAP(0x0700e0, 0x001d, 0x0025, 0x001d, 0x003b, "ControlLeft", CONTROL_LEFT),
  USB_KEYMAP(0x0700e1, 0x002a, 0x0032, 0x002a, 0x0038, "ShiftLeft", SHIFT_LEFT),
  // USB#0700e2: left Alt key (Mac left Option key).
  USB_KEYMAP(0x0700e2, 0x0038, 0x0040, 0x0038, 0x003a, "AltLeft", ALT_LEFT),
  // USB#0700e3: left GUI key, e.g. Windows, Mac Command, ChromeOS Search.
  USB_KEYMAP(0x0700e3, 0x007d, 0x0085, 0xe05b, 0x0037, "MetaLeft", META_LEFT),
  USB_KEYMAP(0x0700e4, 0x0061, 0x0069, 0xe01d, 0x003e, "ControlRight", CONTROL_RIGHT),
  USB_KEYMAP(0x0700e5, 0x0036, 0x003e, 0x0036, 0x003c, "ShiftRight", SHIFT_RIGHT),
  // USB#0700e6: right Alt key (Mac right Option key).
  USB_KEYMAP(0x0700e6, 0x0064, 0x006c, 0xe038, 0x003d, "AltRight", ALT_RIGHT),
  // USB#0700e7: right GUI key, e.g. Windows, Mac Command, ChromeOS Search.
  USB_KEYMAP(0x0700e7, 0x007e, 0x0086, 0xe05c, 0x0036, "MetaRight", META_RIGHT),

  // USB#0700e8 - #07ffff are reserved

  // ==================================
  // USB Usage Page 0x0c: Consumer Page
  // ==================================
  // AL = Application Launch
  // AC = Application Control

  // TODO(garykac): Many XF86 keys have multiple scancodes mapping to them.
  // We need to map all of these into a canonical USB scancode without
  // confusing the reverse-lookup - most likely by simply returning the first
  // found match.

  // TODO(garykac): Find appropriate mappings for:
  // Win#e03c Music - USB#0c0193 is AL_AVCapturePlayback
  // Win#e064 Pictures
  // XKB#0080 XF86LaunchA
  // XKB#0099 XF86Send
  // XKB#009b XF86Xfer
  // XKB#009c XF86Launch1
  // XKB#009d XF86Launch2
  // XKB... remaining XF86 keys

  // KEY_BRIGHTNESS* added in Linux 3.16
  // http://www.usb.org/developers/hidpage/HUTRR41.pdf
  //            USB     evdev    XKB     Win     Mac   Code
  USB_KEYMAP(0x0c0060, 0x0166, 0x016e, 0x0000, 0xffff, NULL, INFO),
  USB_KEYMAP(0x0c0061, 0x0172, 0x017a, 0x0000, 0xffff, NULL, CLOSED_CAPTION_TOGGLE),
  USB_KEYMAP(0x0c006f, 0x00e1, 0x00e9, 0x0000, 0xffff, "BrightnessUp", BRIGHTNESS_UP),
  USB_KEYMAP(0x0c0070, 0x00e0, 0x00e8, 0x0000, 0xffff, "BrightnessDown",
             BRIGHTNESS_DOWN),  // Display Brightness Decrement
  USB_KEYMAP(0x0c0072, 0x01af, 0x01b7, 0x0000, 0xffff, NULL, BRIGHTNESS_TOGGLE),
  USB_KEYMAP(0x0c0073, 0x0250, 0x0258, 0x0000, 0xffff, NULL, BRIGHTNESS_MINIMIUM),
  USB_KEYMAP(0x0c0074, 0x0251, 0x0259, 0x0000, 0xffff, NULL, BRIGHTNESS_MAXIMUM),
  USB_KEYMAP(0x0c0075, 0x00f4, 0x00fc, 0x0000, 0xffff, NULL, BRIGHTNESS_AUTO),
  USB_KEYMAP(0x0c0083, 0x0195, 0x019d, 0x0000, 0xffff, NULL, MEDIA_LAST),
  USB_KEYMAP(0x0c008c, 0x00a9, 0x00b1, 0x0000, 0xffff, NULL, LAUNCH_PHONE),
  USB_KEYMAP(0x0c008d, 0x016a, 0x0172, 0x0000, 0xffff, NULL, PROGRAM_GUIDE),
  USB_KEYMAP(0x0c0094, 0x00ae, 0x00b6, 0x0000, 0xffff, NULL, EXIT),
  USB_KEYMAP(0x0c009c, 0x019a, 0x01a2, 0x0000, 0xffff, NULL, CHANNEL_UP),
  USB_KEYMAP(0x0c009d, 0x019b, 0x01a3, 0x0000, 0xffff, NULL, CHANNEL_DOWN),

  //              USB     evdev    XKB     Win     Mac
  USB_KEYMAP(0x0c00b0, 0x00cf, 0x00d7, 0x0000, 0xffff, "MediaPlay", MEDIA_PLAY),
  //USB_KEYMAP(0x0c00b1, 0x0077, 0x007f, 0x0000, 0xffff, "MediaPause", MEDIA_PAUSE),
  USB_KEYMAP(0x0c00b2, 0x00a7, 0x00af, 0x0000, 0xffff, "MediaRecord", MEDIA_RECORD),
  USB_KEYMAP(0x0c00b3, 0x00d0, 0x00d8, 0x0000, 0xffff, "MediaFastForward", MEDIA_FAST_FORWARD),
  USB_KEYMAP(0x0c00b4, 0x00a8, 0x00b0, 0x0000, 0xffff, "MediaRewind", MEDIA_REWIND),
  USB_KEYMAP(0x0c00b5, 0x00a3, 0x00ab, 0xe019, 0xffff, "MediaTrackNext",
             MEDIA_TRACK_NEXT),
  USB_KEYMAP(0x0c00b6, 0x00a5, 0x00ad, 0xe010, 0xffff, "MediaTrackPrevious",
             MEDIA_TRACK_PREVIOUS),
  USB_KEYMAP(0x0c00b7, 0x00a6, 0x00ae, 0xe024, 0xffff, "MediaStop", MEDIA_STOP),
  USB_KEYMAP(0x0c00b8, 0x00a1, 0x00a9, 0xe02c, 0xffff, "Eject", EJECT),
  USB_KEYMAP(0x0c00cd, 0x00a4, 0x00ac, 0xe022, 0xffff, "MediaPlayPause",
             MEDIA_PLAY_PAUSE),
  USB_KEYMAP(0x0c00cf, 0x0246, 0x024e, 0x0000, 0xffff, NULL, SPEECH_INPUT_TOGGLE),
  USB_KEYMAP(0x0c00e5, 0x00d1, 0x00d9, 0x0000, 0xffff, NULL, BASS_BOOST),
  //USB_KEYMAP(0x0c00e6, 0x0000, 0x0000, 0x0000, 0xffff, NULL, SURROUND_MODE),
  //USB_KEYMAP(0x0c0150, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BALANCE_RIGHT),
  //USB_KEYMAP(0x0c0151, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BALANCE_LEFT ),
  //USB_KEYMAP(0x0c0152, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BASS_INCREMENT),
  //USB_KEYMAP(0x0c0153, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_BASS_DECREMENT),
  //USB_KEYMAP(0x0c0154, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_TREBLE_INCREMENT),
  //USB_KEYMAP(0x0c0155, 0x0000, 0x0000, 0x0000, 0xffff, NULL, AUDIO_TREBLE_DECREMENT),
  // USB#0c0183: AL Consumer Control Configuration
  USB_KEYMAP(0x0c0183, 0x00ab, 0x00b3, 0xe06d, 0xffff, "MediaSelect", MEDIA_SELECT),
  USB_KEYMAP(0x0c0184, 0x01a5, 0x01ad, 0x0000, 0xffff, NULL, LAUNCH_WORD_PROCESSOR),
  USB_KEYMAP(0x0c0186, 0x01a7, 0x01af, 0x0000, 0xffff, NULL, LAUNCH_SPREADSHEET),
  // USB#0x0c018a AL_EmailReader
  USB_KEYMAP(0x0c018a, 0x009b, 0x00a3, 0xe06c, 0xffff, "LaunchMail", LAUNCH_MAIL),
  // USB#0x0c018d: AL Contacts/Address Book
  USB_KEYMAP(0x0c018d, 0x01ad, 0x01b5, 0x0000, 0xffff, NULL, LAUNCH_CONTACTS),
  // USB#0x0c018e: AL Calendar/Schedule
  USB_KEYMAP(0x0c018e, 0x018d, 0x0195, 0x0000, 0xffff, NULL, LAUNCH_CALENDAR),
  // USB#0x0c018f AL Task/Project Manager
  //USB_KEYMAP(0x0c018f, 0x0241, 0x0249, 0x0000, 0xffff, NULL, LAUNCH_TASK_MANAGER),
  // USB#0x0c0190: AL Log/Journal/Timecard
  //USB_KEYMAP(0x0c0190, 0x0242, 0x024a, 0x0000, 0xffff, NULL, LAUNCH_LOG),
  // USB#0x0c0192: AL_Calculator
  USB_KEYMAP(0x0c0192, 0x008c, 0x0094, 0xe021, 0xffff, "LaunchApp2", LAUNCH_APP2),
  // USB#0c0194: My Computer (AL_LocalMachineBrowser)
  USB_KEYMAP(0x0c0194, 0x0090, 0x0098, 0xe06b, 0xffff, "LaunchApp1", LAUNCH_APP1),
  USB_KEYMAP(0x0c0196, 0x0096, 0x009e, 0x0000, 0xffff, NULL, LAUNCH_INTERNET_BROWSER),
  USB_KEYMAP(0x0c019C, 0x01b1, 0x01b9, 0x0000, 0xffff, NULL, LOG_OFF),
  // USB#0x0c019e: AL Terminal Lock/Screensaver
  USB_KEYMAP(0x0c019e, 0x0098, 0x00a0, 0x0000, 0xffff, NULL, LOCK_SCREEN),
  // USB#0x0c019f AL Control Panel
  USB_KEYMAP(0x0c019f, 0x0243, 0x024b, 0x0000, 0xffff, NULL, LAUNCH_CONTROL_PANEL),
  // USB#0x0c01a2: AL Select Task/Application
  USB_KEYMAP(0x0c01a2, 0x0244, 0x024c, 0x0000, 0xffff, "SelectTask", SELECT_TASK),
  // USB#0x0c01a7: AL_Documents
  USB_KEYMAP(0x0c01a7, 0x00eb, 0x00f3, 0x0000, 0xffff, NULL, LAUNCH_DOCUMENTS),
  USB_KEYMAP(0x0c01ab, 0x01b0, 0x01b8, 0x0000, 0xffff, NULL, SPELL_CHECK),
  // USB#0x0c01ae: AL Keyboard Layout
  USB_KEYMAP(0x0c01ae, 0x0176, 0x017e, 0x0000, 0xffff, NULL, LAUNCH_KEYBOARD_LAYOUT),
  USB_KEYMAP(0x0c01b1, 0x0245, 0x024d, 0x0000, 0xffff, "LaunchScreenSaver",
             LAUNCH_SCREEN_SAVER),  // AL Screen Saver
  // USB#0c01b4: Home Directory (AL_FileBrowser) (Explorer)
  //USB_KEYMAP(0x0c01b4, 0x0000, 0x0000, 0x0000, 0xffff, NULL, LAUNCH_FILE_BROWSER),
  // USB#0x0c01b7: AL Audio Browser
  USB_KEYMAP(0x0c01b7, 0x0188, 0x0190, 0x0000, 0xffff, NULL, LAUNCH_AUDIO_BROWSER),
  // USB#0x0c0201: AC New
  USB_KEYMAP(0x0c0201, 0x00b5, 0x00bd, 0x0000, 0xffff, NULL, NEW),
  // USB#0x0c0203: AC Close
  USB_KEYMAP(0x0c0203, 0x00ce, 0x00d6, 0x0000, 0xffff, NULL, CLOSE),
  // USB#0x0c0207: AC Close
  USB_KEYMAP(0x0c0207, 0x00ea, 0x00f2, 0x0000, 0xffff, NULL, SAVE),
  // USB#0x0c0208: AC Print
  USB_KEYMAP(0x0c0208, 0x00d2, 0x00da, 0x0000, 0xffff, NULL, PRINT),
  // USB#0x0c0221:  AC_Search
  USB_KEYMAP(0x0c0221, 0x00d9, 0x00e1, 0xe065, 0xffff, "BrowserSearch", BROWSER_SEARCH),
  // USB#0x0c0223:  AC_Home
  USB_KEYMAP(0x0c0223, 0x00ac, 0x00b4, 0xe032, 0xffff, "BrowserHome", BROWSER_HOME),
  // USB#0x0c0224:  AC_Back
  USB_KEYMAP(0x0c0224, 0x009e, 0x00a6, 0xe06a, 0xffff, "BrowserBack", BROWSER_BACK),
  // USB#0x0c0225:  AC_Forward
  USB_KEYMAP(0x0c0225, 0x009f, 0x00a7, 0xe069, 0xffff, "BrowserForward",
             BROWSER_FORWARD),
  // USB#0x0c0226:  AC_Stop
  USB_KEYMAP(0x0c0226, 0x0080, 0x0088, 0xe068, 0xffff, "BrowserStop", BROWSER_STOP),
  // USB#0x0c0227:  AC_Refresh (Reload)
  USB_KEYMAP(0x0c0227, 0x00ad, 0x00b5, 0xe067, 0xffff, "BrowserRefresh",
             BROWSER_REFRESH),
  // USB#0x0c022a:  AC_Bookmarks (Favorites)
  USB_KEYMAP(0x0c022a, 0x009c, 0x00a4, 0xe066, 0xffff, "BrowserFavorites",
             BROWSER_FAVORITES),
  USB_KEYMAP(0x0c022d, 0x01a2, 0x01aa, 0x0000, 0xffff, NULL, ZOOM_IN),
  USB_KEYMAP(0x0c022e, 0x01a3, 0x01ab, 0x0000, 0xffff, NULL, ZOOM_OUT),
  // USB#0x0c0230:  AC Full Screen View
  //USB_KEYMAP(0x0c0230, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ZOOM_FULL),
  // USB#0x0c0231:  AC Normal View
  //USB_KEYMAP(0x0c0231, 0x0000, 0x0000, 0x0000, 0xffff, NULL, ZOOM_NORMAL),
  // USB#0x0c0232:  AC View Toggle
  USB_KEYMAP(0x0c0232, 0x0000, 0x0000, 0x0000, 0xffff, "ZoomToggle", ZOOM_TOGGLE),
  // USB#0x0c0279:  AC Redo/Repeat
  USB_KEYMAP(0x0c0279, 0x00b6, 0x00be, 0x0000, 0xffff, NULL, REDO),
  // USB#0x0c0289:  AC_Reply
  USB_KEYMAP(0x0c0289, 0x00e8, 0x00f0, 0x0000, 0xffff, "MailReply", MAIL_REPLY),
  // USB#0x0c028b:  AC_ForwardMsg (MailForward)
  USB_KEYMAP(0x0c028b, 0x00e9, 0x00f1, 0x0000, 0xffff, "MailForward", MAIL_FORWARD),
  // USB#0x0c028c:  AC_Send
  USB_KEYMAP(0x0c028c, 0x00e7, 0x00ef, 0x0000, 0xffff, "MailSend", MAIL_SEND),
  with native APIs for converting hardware key codes to unicode characters, we were able to extend that module with a getCurrentKeymap() method. This method returns a JS object mapping physical key names (DOM 3 KeyboardEvent.code values) to objects describing the corresponding character in every modifier state based on the current keyboard layout. For example, here’s one entry from the keymap we return on macOS with the Swiss-German keyboard layout installed… our old friend alt-g.
with native APIs for converting hardware key codes to unicode characters, we were able to extend that module with a getCurrentKeymap() method. This method returns a JS object mapping physical key names (DOM 3 KeyboardEvent.code values) to objects describing the corresponding character in every modifier state based on the current keyboard layout. For example, here’s one entry from the keymap we return on macOS with the Swiss-German keyboard layout installed… our old friend alt-g.

"KeyG": {
  "unmodified": "g",
  "withShift": "G",
  "withAltGraph": "@",
  "withAltGraphShift": "‚"
}

{calculateSpecificity} = require 'clear-cut'
KeyboardLayout = require 'keyboard-layout'

MODIFIERS = new Set(['ctrl', 'alt', 'shift', 'cmd'])
ENDS_IN_MODIFIER_REGEX = /(ctrl|alt|shift|cmd)$/
WHITESPACE_REGEX = /\s+/
KEY_NAMES_BY_KEYBOARD_EVENT_CODE = {
  'Space': 'space',
  'Backspace': 'backspace'
}
NON_CHARACTER_KEY_NAMES_BY_KEYBOARD_EVENT_KEY = {
  'Control': 'ctrl',
  'Meta': 'cmd',
  'ArrowDown': 'down',
  'ArrowUp': 'up',
  'ArrowLeft': 'left',
  'ArrowRight': 'right'
}
MATCH_TYPES = {
  EXACT: 'exact'
  KEYDOWN_EXACT: 'keydownExact'
  PARTIAL: 'partial'
}

isASCIICharacter = (character) ->
  character? and character.length is 1 and character.charCodeAt(0) <= 127

isLatinCharacter = (character) ->
  character? and character.length is 1 and character.charCodeAt(0) <= 0x024F

isUpperCaseCharacter = (character) ->
  character? and character.length is 1 and character.toLowerCase() isnt character

isLowerCaseCharacter = (character) ->
  character? and character.length is 1 and character.toUpperCase() isnt character

usKeymap = null
usCharactersForKeyCode = (code) ->
  usKeymap ?= require('./us-keymap')
  usKeymap[code]

exports.normalizeKeystrokes = (keystrokes) ->
  normalizedKeystrokes = []
  for keystroke in keystrokes.split(WHITESPACE_REGEX)
    if normalizedKeystroke = normalizeKeystroke(keystroke)
      normalizedKeystrokes.push(normalizedKeystroke)
    else
      return false
  normalizedKeystrokes.join(' ')

normalizeKeystroke = (keystroke) ->
  if isKeyup = keystroke.startsWith('^')
    keystroke = keystroke.slice(1)
  keys = parseKeystroke(keystroke)
  return false unless keys

  primaryKey = null
  modifiers = new Set

  for key, i in keys
    if MODIFIERS.has(key)
      modifiers.add(key)
    else
      # only the last key can be a non-modifier
      if i is keys.length - 1
        primaryKey = key
      else
        return false

  if isKeyup
    primaryKey = primaryKey.toLowerCase() if primaryKey?
  else
    modifiers.add('shift') if isUpperCaseCharacter(primaryKey)
    if modifiers.has('shift') and isLowerCaseCharacter(primaryKey)
      primaryKey = primaryKey.toUpperCase()

  keystroke = []
  if not isKeyup or (isKeyup and not primaryKey?)
    keystroke.push('ctrl') if modifiers.has('ctrl')
    keystroke.push('alt') if modifiers.has('alt')
    keystroke.push('shift') if modifiers.has('shift')
    keystroke.push('cmd') if modifiers.has('cmd')
  keystroke.push(primaryKey) if primaryKey?
  keystroke = keystroke.join('-')
  keystroke = "^#{keystroke}" if isKeyup
  keystroke

parseKeystroke = (keystroke) ->
  keys = []
  keyStart = 0
  for character, index in keystroke when character is '-'
    if index > keyStart
      keys.push(keystroke.substring(keyStart, index))
      keyStart = index + 1

      # The keystroke has a trailing - and is invalid
      return false if keyStart is keystroke.length
  keys.push(keystroke.substring(keyStart)) if keyStart < keystroke.length
  keys

exports.keystrokeForKeyboardEvent = (event) ->
  {key, code, ctrlKey, altKey, shiftKey, metaKey} = event

  if key is 'Dead'
    if process.platform isnt 'linux' and characters = KeyboardLayout.getCurrentKeymap()[event.code]
      if ctrlKey and altKey and shiftKey and characters.withAltGraphShift?
        key = characters.withAltGraphShift
      else if process.platform is 'darwin' and altKey and characters.withAltGraph?
        key = characters.withAltGraph
      else if process.platform is 'win32' and ctrlKey and altKey and characters.withAltGraph?
        key = characters.withAltGraph
      else if shiftKey and characters.withShift?
        key = characters.withShift
      else if characters.unmodified?
        key = characters.unmodified

  if KEY_NAMES_BY_KEYBOARD_EVENT_CODE[code]?
    key = KEY_NAMES_BY_KEYBOARD_EVENT_CODE[code]

  isNonCharacterKey = key.length > 1
  if isNonCharacterKey
    key = NON_CHARACTER_KEY_NAMES_BY_KEYBOARD_EVENT_KEY[key] ? key.toLowerCase()
  else
    if altKey
      # All macOS layouts have an alt-modified character variant for every
      # single key. Therefore, if we always favored the alt variant, it would
      # become impossible to bind `alt-*` to anything. Since `alt-*` bindings
      # are rare and we bind very few by default on macOS, we will only shadow
      # an `alt-*` binding with an alt-modified character variant if it is a
      # basic ASCII character.
      if process.platform is 'darwin' and event.code
        nonAltModifiedKey = nonAltModifiedKeyForKeyboardEvent(event)
        if ctrlKey or metaKey or not isASCIICharacter(key)
          key = nonAltModifiedKey
        else if key isnt nonAltModifiedKey
          altKey = false
      # Windows layouts are more sparing in their use of AltGr-modified
      # characters, and the U.S. layout doesn't have any of them at all. That
      # means that if an AltGr variant character exists for the current
      # keystroke, it likely to be the intended character, and we always
      # interpret it as such rather than favoring a `ctrl-alt-*` binding
      # intepretation.
      else if process.platform is 'win32' and ctrlKey and event.code
        nonAltModifiedKey = nonAltModifiedKeyForKeyboardEvent(event)
        if metaKey
          key = nonAltModifiedKey
        else if key isnt nonAltModifiedKey
          ctrlKey = false
          altKey = false
      # Linux has a dedicated `AltGraph` key that is distinct from all other
      # modifiers, so there is no potential ambiguity and we always honor
      # AltGraph.
      else if process.platform is 'linux'
        if event.getModifierState('AltGraph')
          altKey = false

    # Avoid caps-lock captilizing the key without shift being actually pressed
    unless shiftKey
      key = key.toLowerCase()

  # Use US equivalent character for non-latin characters in keystrokes with modifiers
  # or when using the dvorak-qwertycmd layout and holding down the command key.
  if (key.length is 1 and not isLatinCharacter(key)) or
     (metaKey and KeyboardLayout.getCurrentKeyboardLayout() is 'com.apple.keylayout.DVORAK-QWERTYCMD')
    if characters = usCharactersForKeyCode(event.code)
      if event.shiftKey
        key = characters.withShift
      else
        key = characters.unmodified

  keystroke = ''
  if key is 'ctrl' or ctrlKey
    keystroke += 'ctrl'

  if key is 'alt' or altKey
    keystroke += '-' if keystroke.length > 0
    keystroke += 'alt'

  if key is 'shift' or (shiftKey and (isNonCharacterKey or (isLatinCharacter(key) and isUpperCaseCharacter(key))))
    keystroke += '-' if keystroke
    keystroke += 'shift'

  if key is 'cmd' or metaKey
    keystroke += '-' if keystroke
    keystroke += 'cmd'

  unless MODIFIERS.has(key)
    keystroke += '-' if keystroke
    keystroke += key

  keystroke = normalizeKeystroke("^#{keystroke}") if event.type is 'keyup'
  keystroke

nonAltModifiedKeyForKeyboardEvent = (event) ->
  if event.code and (characters = KeyboardLayout.getCurrentKeymap()[event.code])
    if event.shiftKey
      characters.withShift
    else
      characters.unmodified

exports.characterForKeyboardEvent = (event) ->
  event.key unless event.ctrlKey or event.metaKey

exports.calculateSpecificity = calculateSpecificity

exports.isBareModifier = (keystroke) -> ENDS_IN_MODIFIER_REGEX.test(keystroke)

exports.keydownEvent = (key, options) ->
  return buildKeyboardEvent(key, 'keydown', options)

exports.keyupEvent = (key, options) ->
  return buildKeyboardEvent(key, 'keyup', options)

buildKeyboardEvent = (key, eventType, {ctrl, shift, alt, cmd, keyCode, target, location}={}) ->
  ctrlKey = ctrl ? false
  altKey = alt ? false
  shiftKey = shift ? false
  metaKey = cmd ? false
  bubbles = true
  cancelable = true

  event = new KeyboardEvent(eventType, {
    key, ctrlKey, altKey, shiftKey, metaKey, bubbles, cancelable
  })

  if target?
    Object.defineProperty(event, 'target', get: -> target)
    Object.defineProperty(event, 'path', get: -> [target])
  event

# bindingKeystrokes and userKeystrokes are arrays of keystrokes
# e.g. ['ctrl-y', 'ctrl-x', '^x']
exports.keystrokesMatch = (bindingKeystrokes, userKeystrokes) ->
  userKeystrokeIndex = -1
  userKeystrokesHasKeydownEvent = false
  matchesNextUserKeystroke = (bindingKeystroke) ->
    while userKeystrokeIndex < userKeystrokes.length - 1
      userKeystrokeIndex += 1
      userKeystroke = userKeystrokes[userKeystrokeIndex]
      isKeydownEvent = not userKeystroke.startsWith('^')
      userKeystrokesHasKeydownEvent = true if isKeydownEvent
      if bindingKeystroke is userKeystroke
        return true
      else if isKeydownEvent
        return false
    null

  isPartialMatch = false
  bindingRemainderContainsOnlyKeyups = true
  bindingKeystrokeIndex = 0
  for bindingKeystroke in bindingKeystrokes
    unless isPartialMatch
      doesMatch = matchesNextUserKeystroke(bindingKeystroke)
      if doesMatch is false
        return false
      else if doesMatch is null
        # Make sure userKeystrokes with only keyup events doesn't match everything
        if userKeystrokesHasKeydownEvent
          isPartialMatch = true
        else
          return false

    if isPartialMatch
      bindingRemainderContainsOnlyKeyups = false unless bindingKeystroke.startsWith('^')

  # Bindings that match the beginning of the user's keystrokes are not a match.
  # e.g. This is not a match. It would have been a match on the previous keystroke:
  # bindingKeystrokes = ['ctrl-tab', '^tab']
  # userKeystrokes    = ['ctrl-tab', '^tab', '^ctrl']
  return false if userKeystrokeIndex < userKeystrokes.length - 1

  if isPartialMatch and bindingRemainderContainsOnlyKeyups
    MATCH_TYPES.KEYDOWN_EXACT
  else if isPartialMatch
    MATCH_TYPES.PARTIAL
  else
    MATCH_TYPES.EXACT
    
    
    {calculateSpecificity} = require 'clear-cut'
KeyboardLayout = require 'keyboard-layout'

MODIFIERS = new Set(['ctrl', 'alt', 'shift', 'cmd'])
ENDS_IN_MODIFIER_REGEX = /(ctrl|alt|shift|cmd)$/
WHITESPACE_REGEX = /\s+/
KEY_NAMES_BY_KEYBOARD_EVENT_CODE = {
  'Space': 'space',
  'Backspace': 'backspace'
}
NON_CHARACTER_KEY_NAMES_BY_KEYBOARD_EVENT_KEY = {
  'Control': 'ctrl',
  'Meta': 'cmd',
  'ArrowDown': 'down',
  'ArrowUp': 'up',
  'ArrowLeft': 'left',
  'ArrowRight': 'right'
}
MATCH_TYPES = {
  EXACT: 'exact'
  KEYDOWN_EXACT: 'keydownExact'
  PARTIAL: 'partial'
}

isASCIICharacter = (character) ->
  character? and character.length is 1 and character.charCodeAt(0) <= 127

isLatinCharacter = (character) ->
  character? and character.length is 1 and character.charCodeAt(0) <= 0x024F

isUpperCaseCharacter = (character) ->
  character? and character.length is 1 and character.toLowerCase() isnt character

isLowerCaseCharacter = (character) ->
  character? and character.length is 1 and character.toUpperCase() isnt character

usKeymap = null
usCharactersForKeyCode = (code) ->
  usKeymap ?= require('./us-keymap')
  usKeymap[code]

exports.normalizeKeystrokes = (keystrokes) ->
  normalizedKeystrokes = []
  for keystroke in keystrokes.split(WHITESPACE_REGEX)
    if normalizedKeystroke = normalizeKeystroke(keystroke)
      normalizedKeystrokes.push(normalizedKeystroke)
    else
      return false
  normalizedKeystrokes.join(' ')

normalizeKeystroke = (keystroke) ->
  if isKeyup = keystroke.startsWith('^')
    keystroke = keystroke.slice(1)
  keys = parseKeystroke(keystroke)
  return false unless keys

  primaryKey = null
  modifiers = new Set

  for key, i in keys
    if MODIFIERS.has(key)
      modifiers.add(key)
    else
      # only the last key can be a non-modifier
      if i is keys.length - 1
        primaryKey = key
      else
        return false

  if isKeyup
    primaryKey = primaryKey.toLowerCase() if primaryKey?
  else
    modifiers.add('shift') if isUpperCaseCharacter(primaryKey)
    if modifiers.has('shift') and isLowerCaseCharacter(primaryKey)
      primaryKey = primaryKey.toUpperCase()

  keystroke = []
  if not isKeyup or (isKeyup and not primaryKey?)
    keystroke.push('ctrl') if modifiers.has('ctrl')
    keystroke.push('alt') if modifiers.has('alt')
    keystroke.push('shift') if modifiers.has('shift')
    keystroke.push('cmd') if modifiers.has('cmd')
  keystroke.push(primaryKey) if primaryKey?
  keystroke = keystroke.join('-')
  keystroke = "^#{keystroke}" if isKeyup
  keystroke

parseKeystroke = (keystroke) ->
  keys = []
  keyStart = 0
  for character, index in keystroke when character is '-'
    if index > keyStart
      keys.push(keystroke.substring(keyStart, index))
      keyStart = index + 1

      # The keystroke has a trailing - and is invalid
      return false if keyStart is keystroke.length
  keys.push(keystroke.substring(keyStart)) if keyStart < keystroke.length
  keys

exports.keystrokeForKeyboardEvent = (event) ->
  {key, code, ctrlKey, altKey, shiftKey, metaKey} = event

  if key is 'Dead'
    if process.platform isnt 'linux' and characters = KeyboardLayout.getCurrentKeymap()[event.code]
      if ctrlKey and altKey and shiftKey and characters.withAltGraphShift?
        key = characters.withAltGraphShift
      else if process.platform is 'darwin' and altKey and characters.withAltGraph?
        key = characters.withAltGraph
      else if process.platform is 'win32' and ctrlKey and altKey and characters.withAltGraph?
        key = characters.withAltGraph
      else if shiftKey and characters.withShift?
        key = characters.withShift
      else if characters.unmodified?
        key = characters.unmodified

  if KEY_NAMES_BY_KEYBOARD_EVENT_CODE[code]?
    key = KEY_NAMES_BY_KEYBOARD_EVENT_CODE[code]

  isNonCharacterKey = key.length > 1
  if isNonCharacterKey
    key = NON_CHARACTER_KEY_NAMES_BY_KEYBOARD_EVENT_KEY[key] ? key.toLowerCase()
  else
    if altKey
      # All macOS layouts have an alt-modified character variant for every
      # single key. Therefore, if we always favored the alt variant, it would
      # become impossible to bind `alt-*` to anything. Since `alt-*` bindings
      # are rare and we bind very few by default on macOS, we will only shadow
      # an `alt-*` binding with an alt-modified character variant if it is a
      # basic ASCII character.
      if process.platform is 'darwin' and event.code
        nonAltModifiedKey = nonAltModifiedKeyForKeyboardEvent(event)
        if ctrlKey or metaKey or not isASCIICharacter(key)
          key = nonAltModifiedKey
        else if key isnt nonAltModifiedKey
          altKey = false
      # Windows layouts are more sparing in their use of AltGr-modified
      # characters, and the U.S. layout doesn't have any of them at all. That
      # means that if an AltGr variant character exists for the current
      # keystroke, it likely to be the intended character, and we always
      # interpret it as such rather than favoring a `ctrl-alt-*` binding
      # intepretation.
      else if process.platform is 'win32' and ctrlKey and event.code
        nonAltModifiedKey = nonAltModifiedKeyForKeyboardEvent(event)
        if metaKey
          key = nonAltModifiedKey
        else if key isnt nonAltModifiedKey
          ctrlKey = false
          altKey = false
      # Linux has a dedicated `AltGraph` key that is distinct from all other
      # modifiers, so there is no potential ambiguity and we always honor
      # AltGraph.
      else if process.platform is 'linux'
        if event.getModifierState('AltGraph')
          altKey = false

    # Avoid caps-lock captilizing the key without shift being actually pressed
    unless shiftKey
      key = key.toLowerCase()

  # Use US equivalent character for non-latin characters in keystrokes with modifiers
  # or when using the dvorak-qwertycmd layout and holding down the command key.
  if (key.length is 1 and not isLatinCharacter(key)) or
     (metaKey and KeyboardLayout.getCurrentKeyboardLayout() is 'com.apple.keylayout.DVORAK-QWERTYCMD')
    if characters = usCharactersForKeyCode(event.code)
      if event.shiftKey
        key = characters.withShift
      else
        key = characters.unmodified

  keystroke = ''
  if key is 'ctrl' or ctrlKey
    keystroke += 'ctrl'

  if key is 'alt' or altKey
    keystroke += '-' if keystroke.length > 0
    keystroke += 'alt'

  if key is 'shift' or (shiftKey and (isNonCharacterKey or (isLatinCharacter(key) and isUpperCaseCharacter(key))))
    keystroke += '-' if keystroke
    keystroke += 'shift'

  if key is 'cmd' or metaKey
    keystroke += '-' if keystroke
    keystroke += 'cmd'

  unless MODIFIERS.has(key)
    keystroke += '-' if keystroke
    keystroke += key

  keystroke = normalizeKeystroke("^#{keystroke}") if event.type is 'keyup'
  keystroke

nonAltModifiedKeyForKeyboardEvent = (event) ->
  if event.code and (characters = KeyboardLayout.getCurrentKeymap()[event.code])
    if event.shiftKey
      characters.withShift
    else
      characters.unmodified

exports.characterForKeyboardEvent = (event) ->
  event.key unless event.ctrlKey or event.metaKey

exports.calculateSpecificity = calculateSpecificity

exports.isBareModifier = (keystroke) -> ENDS_IN_MODIFIER_REGEX.test(keystroke)

exports.keydownEvent = (key, options) ->
  return buildKeyboardEvent(key, 'keydown', options)

exports.keyupEvent = (key, options) ->
  return buildKeyboardEvent(key, 'keyup', options)

buildKeyboardEvent = (key, eventType, {ctrl, shift, alt, cmd, keyCode, target, location}={}) ->
  ctrlKey = ctrl ? false
  altKey = alt ? false
  shiftKey = shift ? false
  metaKey = cmd ? false
  bubbles = true
  cancelable = true

  event = new KeyboardEvent(eventType, {
    key, ctrlKey, altKey, shiftKey, metaKey, bubbles, cancelable
  })

  if target?
    Object.defineProperty(event, 'target', get: -> target)
    Object.defineProperty(event, 'path', get: -> [target])
  event

# bindingKeystrokes and userKeystrokes are arrays of keystrokes
# e.g. ['ctrl-y', 'ctrl-x', '^x']
exports.keystrokesMatch = (bindingKeystrokes, userKeystrokes) ->
  userKeystrokeIndex = -1
  userKeystrokesHasKeydownEvent = false
  matchesNextUserKeystroke = (bindingKeystroke) ->
    while userKeystrokeIndex < userKeystrokes.length - 1
      userKeystrokeIndex += 1
      userKeystroke = userKeystrokes[userKeystrokeIndex]
      isKeydownEvent = not userKeystroke.startsWith('^')
      userKeystrokesHasKeydownEvent = true if isKeydownEvent
      if bindingKeystroke is userKeystroke
        return true
      else if isKeydownEvent
        return false
    null

  isPartialMatch = false
  bindingRemainderContainsOnlyKeyups = true
  bindingKeystrokeIndex = 0
  for bindingKeystroke in bindingKeystrokes
    unless isPartialMatch
      doesMatch = matchesNextUserKeystroke(bindingKeystroke)
      if doesMatch is false
        return false
      else if doesMatch is null
        # Make sure userKeystrokes with only keyup events doesn't match everything
        if userKeystrokesHasKeydownEvent
          isPartialMatch = true
        else
          return false

    if isPartialMatch
      bindingRemainderContainsOnlyKeyups = false unless bindingKeystroke.startsWith('^')

  # Bindings that match the beginning of the user's keystrokes are not a match.
  # e.g. This is not a match. It would have been a match on the previous keystroke:
  # bindingKeystrokes = ['ctrl-tab', '^tab']
  # userKeystrokes    = ['ctrl-tab', '^tab', '^ctrl']
  return false if userKeystrokeIndex < userKeystrokes.length - 1

  if isPartialMatch and bindingRemainderContainsOnlyKeyups
    MATCH_TYPES.KEYDOWN_EXACT
  else if isPartialMatch
    MATCH_TYPES.PARTIAL
  else
    MATCH_TYPES.EXACT
    
    Worker information

hostname: production-4-worker-org-c-5-gce:e3d35907-6f5e-4190-afe7-e978d31d4fd9

version: v2.9.3 https://github.com/travis-ci/worker/tree/a41c772c638071fbbdbc106f31a664c0532e0c36

instance: testing-gce-6f9208f4-da28-450f-8b8b-f0d5434a2d94:travis-ci-nodejs-precise-1491943444 (via amqp)

startup: 21.321889554s

system_info
Build system information

Build language: node_js

Build group: stable

Build dist: precise

Build id: 252070272

Job id: 252070275

travis-build version: 6094b6ae8

Build image provisioning date and time

Tue Apr 11 21:39:22 UTC 2017

Operating System Details

Distributor ID:	Ubuntu

Description:	Ubuntu 12.04.5 LTS

Release:	12.04

Codename:	precise

Linux Version

3.13.0-115-generic

Cookbooks Version

cc4eb5e https://github.com/travis-ci/travis-cookbooks/tree/cc4eb5e

Git version

git version 1.8.5.6

bash version

GNU bash, version 4.2.25(1)-release (x86_64-pc-linux-gnu)

Copyright (C) 2011 Free Software Foundation, Inc.

License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>


This is free software; you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.

GCC version

gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

Copyright (C) 2011 Free Software Foundation, Inc.

This is free software; see the source for copying conditions.  There is NO

warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


LLVM version

clang version 3.4 (tags/RELEASE_34/final)

Target: x86_64-unknown-linux-gnu

Thread model: posix

Pre-installed Ruby versions

ruby-2.2.6

Pre-installed Node.js versions

iojs-v1.1.0

v0.10

v0.10.18

v0.10.36

v0.11.15

v0.6.21

v0.8.27

Pre-installed Go versions

1.7.4

mysql --version

mysql  Ver 14.14 Distrib 5.5.54, for debian-linux-gnu (x86_64) using readline 6.2

Pre-installed PostgreSQL versions

9.1.24

9.2.20

9.3.16

9.4.11

9.5.6

Redis version

redis-server 3.0.7

riak version

2.0.2

memcached version

1.4.13

MongoDB version

MongoDB 2.4.14

CouchDB version

couchdb 1.6.1

Installed Sphinx versions

2.0.10

2.1.9

2.2.6

Default Sphinx version

2.2.6

Installed Firefox version

firefox 38.4.0esr

PhantomJS version

1.9.8

ant -version

Apache Ant(TM) version 1.8.2 compiled on December 3 2011

mvn -version

Apache Maven 3.2.5 (12a6b3acb947671f09b81f49094c53f426d8cea1; 2014-12-14T17:29:23+00:00)

Maven home: /usr/local/maven

Java version: 1.7.0_80, vendor: Oracle Corporation

Java home: /usr/lib/jvm/java-7-oracle/jre

Default locale: en, platform encoding: UTF-8

OS name: "linux", version: "3.13.0-115-generic", arch: "amd64", family: "unix"


W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise-updates/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise-backports/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://us-central1.gce.archive.ubuntu.com/ubuntu/dists/precise/Release.gpg: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://security.ubuntu.com/ubuntu/dists/precise-security/InRelease: Signature by key 630239CC130E1A7FD81A27B140976EAF437D05B5 uses weak digest algorithm (SHA1)

W: http://downloads-distro.mongodb.org/repo/debian-sysvinit/dists/dist/Release.gpg: Signature by key 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10 uses weak digest algorithm (SHA1)

W: http://ppa.launchpad.net/couchdb/stable/ubuntu/dists/precise/Release.gpg: Signature by key 15866BAFD9BCC4F3C1E0DFC7D69548E1C17EAB57 uses weak digest algorithm (SHA1)

W: http://ppa.launchpad.net/git-core/v1.8/ubuntu/dists/precise/Release.gpg: Signature by key E1DD270288B4E6030699E45FA1715D88E1DF1F24 uses weak digest algorithm (SHA1)

git.checkout
0.70s$ git clone --depth=1 --branch=master https://github.com/atom/keyboard-layout.git atom/keyboard-layout

Cloning into 'atom/keyboard-layout'...

remote: Counting objects: 22, done.

remote: Compressing objects: 100% (20/20), done.

remote: Total 22 (delta 0), reused 9 (delta 0), pack-reused 0

Unpacking objects: 100% (22/22), done.

Checking connectivity... done.


$ cd atom/keyboard-layout

$ git checkout -qf b8b93241fc7578481588b9495d4464dd7fb4b98e

apt
Installing APT Packages (BETA)

$ export DEBIAN_FRONTEND=noninteractive

2.31s$ sudo -E apt-get -yq update &>> ~/apt-get-update.log


5.46s$ sudo -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install clang-3.3 libx11-dev libxkbfile-dev

Reading package lists...

Building dependency tree...

Reading state information...

libx11-dev is already the newest version (2:1.4.99.1-0ubuntu2.3).

libx11-dev set to manually installed.

The following additional packages will be installed:

  libclang-common-3.3-dev libclang1-3.3 libllvm3.3

Recommended packages:

  llvm-3.3-dev

The following NEW packages will be installed:

  clang-3.3 libclang-common-3.3-dev libclang1-3.3 libllvm3.3 libxkbfile-dev

0 upgraded, 5 newly installed, 0 to remove and 41 not upgraded.

Need to get 25.9 MB of archives.

After this operation, 70.0 MB of additional disk space will be used.

Get:1 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libllvm3.3 amd64 1:3.3-5ubuntu4~precise1 [9,040 kB]

Get:2 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libclang-common-3.3-dev amd64 1:3.3-5ubuntu4~precise1 [573 kB]

Get:3 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libclang1-3.3 amd64 1:3.3-5ubuntu4~precise1 [4,837 kB]

Get:4 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/universe amd64 clang-3.3 amd64 1:3.3-5ubuntu4~precise1 [11.4 MB]

Get:5 http://us-central1.gce.archive.ubuntu.com/ubuntu precise-updates/main amd64 libxkbfile-dev amd64 1:1.0.7-1ubuntu0.1 [88.9 kB]

Fetched 25.9 MB in 1s (14.8 MB/s)

Selecting previously unselected package libllvm3.3.

(Reading database ... 75245 files and directories currently installed.)

Unpacking libllvm3.3 (from .../libllvm3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libclang-common-3.3-dev.

Unpacking libclang-common-3.3-dev (from .../libclang-common-3.3-dev_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libclang1-3.3.

Unpacking libclang1-3.3 (from .../libclang1-3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package clang-3.3.

Unpacking clang-3.3 (from .../clang-3.3_1%3a3.3-5ubuntu4~precise1_amd64.deb) ...

Selecting previously unselected package libxkbfile-dev.

Unpacking libxkbfile-dev (from .../libxkbfile-dev_1%3a1.0.7-1ubuntu0.1_amd64.deb) ...

Processing triggers for man-db ...

Setting up libllvm3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up libclang-common-3.3-dev (1:3.3-5ubuntu4~precise1) ...

Setting up libclang1-3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up clang-3.3 (1:3.3-5ubuntu4~precise1) ...

Setting up libxkbfile-dev (1:1.0.7-1ubuntu0.1) ...

Processing triggers for libc-bin ...

ldconfig deferred processing now taking place

W: --force-yes is deprecated, use one of the options starting with --allow instead.



Setting environment variables from .travis.yml

$ export DISPLAY=:99.0

$ export CC=clang

$ export CXX=clang++

$ export npm_config_clang=1


Updating nvm

nvm.install
3.00s$ nvm install 6

Downloading and installing node v6.11.0...

Downloading https://nodejs.org/dist/v6.11.0/node-v6.11.0-linux-x64.tar.xz...

######################################################################## 100.0%

Computing checksum with sha256sum

Checksums matched!

Now using node v6.11.0 (npm v3.10.10)


$ node --version

v6.11.0

$ npm --version

3.10.10

$ nvm --version

0.33.2

before_install
0.01s$ /sbin/start-stop-daemon --start --quiet --pidfile /tmp/custom_xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1280x1024x16


install.npm
5.88s$ npm install 

npm WARN deprecated minimatch@0.2.14: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN deprecated minimatch@0.4.0: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN deprecated minimatch@0.3.0: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm WARN prefer global jasmine-node@1.10.2 should be installed with -g


> keyboard-layout@2.0.13 install /home/travis/build/atom/keyboard-layout

> node-gyp rebuild


gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

gyp WARN download NVM_NODEJS_ORG_MIRROR is deprecated and will be removed in node-gyp v4, please use NODEJS_ORG_MIRROR

make: Entering directory `/home/travis/build/atom/keyboard-layout/build'

  CXX(target) Release/obj.target/keyboard-layout-manager/src/keyboard-layout-manager-linux.o

  SOLINK_MODULE(target) Release/obj.target/keyboard-layout-manager.node

  COPY Release/keyboard-layout-manager.node

make: Leaving directory `/home/travis/build/atom/keyboard-layout/build'

keyboard-layout@2.0.13 /home/travis/build/atom/keyboard-layout

├── event-kit@2.3.0 

├─┬ jasmine-focused@1.0.7 

│ ├─┬ jasmine-node@1.10.2  (git+https://github.com/kevinsawicki/jasmine-node.git#81af4f953a2b7dfb5bde8331c05362a4b464c5ef)

│ │ ├── coffee-script@1.12.6 

│ │ ├─┬ coffeestack@1.1.2 

│ │ │ ├── coffee-script@1.8.0 

│ │ │ ├─┬ fs-plus@2.10.1 

│ │ │ │ ├── async@1.5.2 

│ │ │ │ ├── mkdirp@0.5.1 

│ │ │ │ └─┬ rimraf@2.6.1 

│ │ │ │   └─┬ glob@7.1.2 

│ │ │ │     ├── fs.realpath@1.0.0 

│ │ │ │     ├─┬ inflight@1.0.6 

│ │ │ │     │ └── wrappy@1.0.2 

│ │ │ │     ├─┬ minimatch@3.0.4 

│ │ │ │     │ └─┬ brace-expansion@1.1.8 

│ │ │ │     │   ├── balanced-match@1.0.0 

│ │ │ │     │   └── concat-map@0.0.1 

│ │ │ │     ├── once@1.4.0 

│ │ │ │     └── path-is-absolute@1.0.1 

│ │ │ └─┬ source-map@0.1.43 

│ │ │   └── amdefine@1.0.1 

│ │ ├─┬ gaze@0.3.4 

│ │ │ ├─┬ fileset@0.1.8 

│ │ │ │ ├─┬ glob@3.2.11 

│ │ │ │ │ ├── inherits@2.0.3 

│ │ │ │ │ └── minimatch@0.3.0 

│ │ │ │ └── minimatch@0.4.0 

│ │ │ └─┬ minimatch@0.2.14 

│ │ │   ├── lru-cache@2.7.3 

│ │ │   └── sigmund@1.0.1 

│ │ ├─┬ jasmine-reporters@2.2.1 

│ │ │ ├─┬ mkdirp@0.5.1 

│ │ │ │ └── minimist@0.0.8 

│ │ │ └── xmldom@0.1.27 

│ │ ├── mkdirp@0.3.5 

│ │ ├── requirejs@2.3.3 

│ │ └── underscore@1.8.3 

│ ├─┬ underscore-plus@1.6.6 

│ │ └── underscore@1.6.0 

│ └── walkdir@0.0.7 

└── nan@2.6.2 


npm WARN keyboard-layout@2.0.13 No license field.


0.80s$ npm test


> keyboard-layout@2.0.13 test /home/travis/build/atom/keyboard-layout

> jasmine-focused --captureExceptions --forceexit spec


..


Finished in 0.009 seconds

2 tests, 3 assertions, 0 failures, 0 skipped





The command "npm test" exited with 0.


Done. Your build exited with 0.

Worker information

hostname: wjb-2:7befed09-7281-4094-946c-44f109df1451

version: v2.6.2 https://github.com/travis-ci/worker/tree/fdccca4efd347ebc889baae641ccbf55bb871d19

instance: 30d3854c-b4f3-469b-b4eb-b8f654d115d6:travis-ci-osx10.11-xcode7.3-1480691248

startup: 1m47.304184053s

system_info
Build system information

Build language: objective-c

Build id: 225654367

Job id: 225654368

travis-build version: 6030eec36


fix.CVE-2015-7547
$ export DEBIAN_FRONTEND=noninteractive

Fix WWDRCA Certificate

$ rvm use

Warning! PATH is not properly set up, '/Users/travis/.rvm/gems/ruby-2.0.0-p648/bin' is not at first place,

         usually this is caused by shell initialization files - check them for 'PATH=...' entries,

         it might also help to re-add RVM to your dotfiles: 'rvm get stable --auto-dotfiles',

         to fix temporarily in this shell session run: 'rvm use ruby-2.0.0-p648'.

Using /Users/travis/.rvm/gems/ruby-2.0.0-p648

git.checkout
2.24s$ git clone --depth=50 --branch=master https://github.com/atom/incompatible-packages.git atom/incompatible-packages

Cloning into 'atom/incompatible-packages'...

remote: Counting objects: 334, done.

remote: Compressing objects: 100% (148/148), done.

remote: Total 334 (delta 177), reused 329 (delta 176), pack-reused 0

Receiving objects: 100% (334/334), 48.79 KiB | 0 bytes/s, done.

Resolving deltas: 100% (177/177), done.


$ cd atom/incompatible-packages

$ git checkout -qf ae6eceb6a580b365b2e1014ef0a39b4815bf1958

rvm
0.64s$ rvm use default

Using /Users/travis/.rvm/gems/ruby-2.0.0-p648


$ ruby --version

ruby 2.0.0p648 (2015-12-16 revision 53162) [x86_64-darwin15.0.0]

$ rvm --version

rvm 1.27.0 (latest) by Wayne E. Seguin <wayneeseguin@gmail.com>, Michal Papis <mpapis@gmail.com> [https://rvm.io/]

$ bundle --version

Bundler version 1.13.2

announce
$ xcodebuild -version -sdk

MacOSX10.11.sdk - OS X 10.11 (macosx10.11)

SDKVersion: 10.11

Path: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk

PlatformVersion: 1.1

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform

ProductBuildVersion: 15E60

ProductCopyright: 1983-2016 Apple Inc.

ProductName: Mac OS X

ProductUserVisibleVersion: 10.11.4

ProductVersion: 10.11.4


iPhoneOS9.3.sdk - iOS 9.3 (iphoneos9.3)

SDKVersion: 9.3

Path: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk

PlatformVersion: 9.3

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform

ProductBuildVersion: 13E230

ProductCopyright: 1983-2016 Apple Inc.

ProductName: iPhone OS

ProductVersion: 9.3


iPhoneSimulator9.3.sdk - Simulator - iOS 9.3 (iphonesimulator9.3)

SDKVersion: 9.3

Path: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator9.3.sdk

PlatformVersion: 9.3

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform

ProductBuildVersion: 13E230

ProductCopyright: 1983-2016 Apple Inc.

ProductName: iPhone OS

ProductVersion: 9.3


AppleTVOS9.2.sdk - tvOS 9.2 (appletvos9.2)

SDKVersion: 9.2

Path: /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS9.2.sdk

PlatformVersion: 9.2

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform

ProductBuildVersion: 13Y227

ProductCopyright: 1983-2016 Apple Inc.

ProductName: Apple TVOS

ProductVersion: 9.2


AppleTVSimulator9.2.sdk - Simulator - tvOS 9.2 (appletvsimulator9.2)

SDKVersion: 9.2

Path: /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator9.2.sdk

PlatformVersion: 9.2

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform

ProductBuildVersion: 13Y227

ProductCopyright: 1983-2016 Apple Inc.

ProductName: Apple TVOS

ProductVersion: 9.2


WatchOS2.2.sdk - watchOS 2.2 (watchos2.2)

SDKVersion: 2.2

Path: /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS2.2.sdk

PlatformVersion: 2.2

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform

ProductBuildVersion: 13V143

ProductCopyright: 1983-2016 Apple Inc.

ProductName: Watch OS

ProductVersion: 2.2


WatchSimulator2.2.sdk - Simulator - watchOS 2.2 (watchsimulator2.2)

SDKVersion: 2.2

Path: /Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator2.2.sdk

PlatformVersion: 2.2

PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform

ProductBuildVersion: 13V143

ProductCopyright: 1983-2016 Apple Inc.

ProductName: Watch OS

ProductVersion: 2.2


Xcode 7.3.1

Build version 7D1014

$ xctool -version

0.2.9

$ xcrun simctl list

2017-04-25 15:38:49.481 simctl[2428:5153] Failed to locate a valid instance of CoreSimulatorService in the bootstrap.  Adding it now.

== Device Types ==

iPhone 4s (com.apple.CoreSimulator.SimDeviceType.iPhone-4s)

iPhone 5 (com.apple.CoreSimulator.SimDeviceType.iPhone-5)

iPhone 5s (com.apple.CoreSimulator.SimDeviceType.iPhone-5s)

iPhone 6 (com.apple.CoreSimulator.SimDeviceType.iPhone-6)

iPhone 6 Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus)

iPhone 6s (com.apple.CoreSimulator.SimDeviceType.iPhone-6s)

iPhone 6s Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus)

iPad 2 (com.apple.CoreSimulator.SimDeviceType.iPad-2)

iPad Retina (com.apple.CoreSimulator.SimDeviceType.iPad-Retina)

iPad Air (com.apple.CoreSimulator.SimDeviceType.iPad-Air)

iPad Air 2 (com.apple.CoreSimulator.SimDeviceType.iPad-Air-2)

iPad Pro (com.apple.CoreSimulator.SimDeviceType.iPad-Pro)

Apple TV 1080p (com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p)

Apple Watch - 38mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-38mm)

Apple Watch - 42mm (com.apple.CoreSimulator.SimDeviceType.Apple-Watch-42mm)

== Runtimes ==

iOS 8.1 (8.1 - 12B411) (com.apple.CoreSimulator.SimRuntime.iOS-8-1)

iOS 8.2 (8.2 - 12D508) (com.apple.CoreSimulator.SimRuntime.iOS-8-2)

iOS 8.3 (8.3 - 12F70) (com.apple.CoreSimulator.SimRuntime.iOS-8-3)

iOS 8.4 (8.4 - 12H141) (com.apple.CoreSimulator.SimRuntime.iOS-8-4)

iOS 9.0 (9.0 - 13A344) (com.apple.CoreSimulator.SimRuntime.iOS-9-0)

iOS 9.1 (9.1 - 13B143) (com.apple.CoreSimulator.SimRuntime.iOS-9-1)

iOS 9.2 (9.2 - 13C75) (com.apple.CoreSimulator.SimRuntime.iOS-9-2)

iOS 9.3 (9.3 - 13E230) (com.apple.CoreSimulator.SimRuntime.iOS-9-3)

tvOS 9.0 (9.0 - 13T395) (com.apple.CoreSimulator.SimRuntime.tvOS-9-0)

tvOS 9.1 (9.1 - 13U85) (com.apple.CoreSimulator.SimRuntime.tvOS-9-1)

tvOS 9.2 (9.2 - 13Y227) (com.apple.CoreSimulator.SimRuntime.tvOS-9-2)

watchOS 2.0 (2.0 - 13S343) (com.apple.CoreSimulator.SimRuntime.watchOS-2-0)

watchOS 2.1 (2.1 - 13S661) (com.apple.CoreSimulator.SimRuntime.watchOS-2-1)

watchOS 2.2 (2.2 - 13V143) (com.apple.CoreSimulator.SimRuntime.watchOS-2-2)

== Devices ==

-- iOS 8.1 --

    iPhone 4s (D72029C0-E8E1-4349-B423-E458466135B3) (Shutdown)

    iPhone 5 (FE241E16-B109-4335-99E6-592D1C7F408D) (Shutdown)

    iPhone 5s (8DC0EE03-9484-4184-A7AF-444BDC4EDDC8) (Shutdown)

    iPhone 6 (0249A013-A2D3-4F9F-922F-41961FEF5AEC) (Shutdown)

    iPhone 6 Plus (80BE7384-8D7F-4C54-850F-B7124F36901A) (Shutdown)

    iPad 2 (54BBC779-9C27-4623-84F7-09AB40DA0511) (Shutdown)

    iPad Retina (AF73A878-6742-48B4-9E95-924F426D8024) (Shutdown)

    iPad Air (A19FFEC9-8F29-478B-A0E4-7899F1F7E294) (Shutdown)

-- iOS 8.2 --

    iPhone 4s (08BF2B8B-01AD-4D7E-8AD9-ABBA8E56F76C) (Shutdown)

    iPhone 5 (1D82F576-F3CF-4440-8BD7-50C1E6B09078) (Shutdown)

    iPhone 5s (8BCD5169-9E0A-4C66-AC07-C89C1645F792) (Shutdown)

    iPhone 6 (2946EC95-6869-41BD-9AE0-053DE2507C92) (Shutdown)

    iPhone 6 Plus (FFE93318-428D-4B7A-B0F2-8173137E6F08) (Shutdown)

    iPad 2 (89D92608-E407-4EBE-B4AC-6158A70B6D84) (Shutdown)

    iPad Retina (7BD97578-5F31-4ED2-83EE-CFAEFC349C1D) (Shutdown)

    iPad Air (28D167AE-4AEA-4439-8380-87E25676FBCF) (Shutdown)

-- iOS 8.3 --

    iPhone 4s (C2DB0396-4E4F-44BE-92E6-D9DB00655ABE) (Shutdown)

    iPhone 5 (422A3E7C-28CC-4B6F-816F-3798A9760695) (Shutdown)

    iPhone 5s (277010E2-3593-475F-A765-51585005820A) (Shutdown)

    iPhone 6 (367F7810-F574-4D1E-B851-7B77ECA5A1ED) (Shutdown)

    iPhone 6 Plus (BF54AC9E-2952-47C7-9103-D9119C7BF9C5) (Shutdown)

    iPad 2 (7827D6DF-AA72-44F1-B823-A5423335A83E) (Shutdown)

    iPad Retina (995BBCE9-D891-4677-AEEF-D717C287BCAA) (Shutdown)

    iPad Air (77E2AEFB-47C3-4EBD-ADA0-0D63EF4B9934) (Shutdown)

-- iOS 8.4 --

    iPhone 4s (8534B11F-B3B7-4A27-8E66-E57A8E3191D4) (Shutdown)

    iPhone 5 (7A4E528E-4FC2-444B-A04C-AC6359714007) (Shutdown)

    iPhone 5s (DE2DD58A-577E-4AB1-9952-9B5BC7D5438B) (Shutdown)

    iPhone 6 (F35B9D49-B895-4AA5-99D5-2F67AF083800) (Shutdown)

    iPhone 6 Plus (AECF5DE0-D8C3-4FFE-B5B2-FA69A730B17F) (Shutdown)

    iPad 2 (FC4229DD-8149-40C9-8920-ADAD8519F73D) (Shutdown)

    iPad Retina (AE315D63-9481-491B-AD8F-56D8CE7A72C1) (Shutdown)

    iPad Air (4F945C66-4536-45E4-B0B9-ADE47A265410) (Shutdown)

-- iOS 9.0 --

    iPhone 4s (0CFF0929-C816-40DD-82EE-5D39A252BC27) (Shutdown)

    iPhone 5 (2D041DE9-345D-4421-95C7-DE0BECD8C107) (Shutdown)

    iPhone 5s (1BAD31C3-7F12-4F75-9DEE-90547BDD57A5) (Shutdown)

    iPhone 6 (06C2614B-FB3A-4CCB-8985-D1EB81FA72B3) (Shutdown)

    iPhone 6 Plus (365C6809-B40B-4606-B909-E76A14776605) (Shutdown)

    iPhone 6s (8879693C-DB47-4F15-B633-02451930F575) (Shutdown)

    iPhone 6s Plus (97921B52-219A-4D91-89DC-DD6E500C529E) (Shutdown)

    iPad 2 (734085C9-563E-4EAD-9865-2DD9507F0368) (Shutdown)

    iPad Retina (A64749FA-139C-468C-9C3E-A981FB9505DC) (Shutdown)

    iPad Air (0B9E9008-6A4A-432A-8D11-5BBF28427339) (Shutdown)

    iPad Air 2 (C82EBA89-5E34-4CBD-8AFF-83E3F9D7AA72) (Shutdown)

-- iOS 9.1 --

    iPhone 4s (702096B5-AD38-4372-8FAC-B767DD570381) (Shutdown)

    iPhone 5 (391F23B1-B90A-400A-9BEB-74DD237DA9B4) (Shutdown)

    iPhone 5s (8C3A1186-41AA-46F2-9FE0-AD83223806BC) (Shutdown)

    iPhone 6 (147DFC74-0D2D-4F8D-B320-FB0146F92A02) (Shutdown)

    iPhone 6 Plus (E0F51644-23E5-4001-B2A2-2F6061D16842) (Shutdown)

    iPhone 6s (742929A4-D5DE-45EC-A02A-5B6B0746E872) (Shutdown)

    iPhone 6s Plus (17DA815A-BC22-4D5D-B10F-78B6681465B1) (Shutdown)

    iPad 2 (51051ADF-66E1-47E6-A6F4-C3307E5AED1C) (Shutdown)

    iPad Retina (8D70073B-E4AF-47AF-81A8-67C6F451572F) (Shutdown)

    iPad Air (BC2D2248-3FC0-45D5-9467-A8CB929E94EF) (Shutdown)

    iPad Air 2 (40906E79-B473-4911-9FC4-150A2BA47E0E) (Shutdown)

    iPad Pro (D564983F-3014-495A-A33B-9A0FF8AAEF9A) (Shutdown)

-- iOS 9.2 --

    iPhone 4s (371F5AA5-E0BD-4CEC-AC69-3AA71893B3EB) (Shutdown)

    iPhone 5 (E6E0CB60-8B67-4094-A32A-D4CB2D9BA810) (Shutdown)

    iPhone 5s (336B4CAC-7163-4CF5-B94C-05C38209C5D4) (Shutdown)

    iPhone 6 (7CE1CE63-4A8C-42DF-A593-D42C6DCCE3DD) (Shutdown)

    iPhone 6 Plus (78EAB22D-F99D-43C2-B70B-5D4335433E8F) (Shutdown)

    iPhone 6s (801C6D30-4650-4C34-86FF-AE3D32B5D248) (Shutdown)

    iPhone 6s Plus (EF14975A-06EA-4CD6-8003-0767995A2DC0) (Shutdown)

    iPad 2 (1C65F4EC-E786-4041-A002-CBC354F3F4FA) (Shutdown)

    iPad Retina (72FDCC5F-DD27-4037-B153-8DA29CEFBCC7) (Shutdown)

    iPad Air (2647DAD5-E0B3-4EF6-AE5D-F0FC6FBD4CB0) (Shutdown)

    iPad Air 2 (288C635B-CB5F-4655-84F4-5E9179935A0E) (Shutdown)

    iPad Pro (57CE6447-EC97-4DF7-9B6E-F2005D06674E) (Shutdown)

-- iOS 9.3 --

    iPhone 4s (75FC400A-B2AA-4DD6-B159-8687FAA5018A) (Shutdown)

    iPhone 5 (8A441414-5FF3-40BC-908F-DE54D3682324) (Shutdown)

    iPhone 5s (EA3443AB-BF51-420B-BBA3-A1340FE48D1A) (Shutdown)

    iPhone 6 (C2DFA409-9034-4F2B-984F-DE52EBE6FFEE) (Shutdown)

    iPhone 6 Plus (B00DD9A7-8338-4BB5-B2E9-3FC8176D6219) (Shutdown)

    iPhone 6s (5752202B-E7A2-4B6C-9D7B-B211C2F54654) (Shutdown)

    iPhone 6s Plus (989606C6-1BE4-425F-9497-43D9D37F0BCC) (Shutdown)

    iPad 2 (7949A19D-5898-41B1-819F-E0A6698130B6) (Shutdown)

    iPad Retina (16488494-E543-4A22-8412-FAF93FC56383) (Shutdown)

    iPad Air (5EBD4B7E-2BA4-4465-B9A9-79ECEA8FEF31) (Shutdown)

    iPad Air 2 (B965ED5C-0F59-46A2-A399-D8967810013C) (Shutdown)

    iPad Pro (14D4D76B-7AFA-4C1D-B048-1D7B7AA1FD02) (Shutdown)

-- tvOS 9.0 --

    Apple TV 1080p (BC3949C2-2FAF-49CD-9DD5-ECA6DEA4F55D) (Shutdown)

-- tvOS 9.1 --

    Apple TV 1080p (4554D612-B8D2-4B06-B2A6-C1AF36A24AF2) (Shutdown)

-- tvOS 9.2 --

    Apple TV 1080p (698204F0-E732-4FE9-AA26-A028916474B1) (Shutdown)

-- watchOS 2.0 --

    Apple Watch - 38mm (F25D93AF-90E3-47E9-8476-FF2A6842B8C9) (Shutdown)

    Apple Watch - 42mm (7BD59DE3-3934-4A3E-99CA-C91865B9660A) (Shutdown)

-- watchOS 2.1 --

    Apple Watch - 38mm (2895E2EC-21C6-4A36-AD9F-A8537C03C754) (Shutdown)

    Apple Watch - 42mm (D72A0C6B-91F9-4BAE-875F-D9FAFC132A7D) (Shutdown)

-- watchOS 2.2 --

    Apple Watch - 38mm (22B5BC0E-ACD6-490E-B95E-FB77ECCEE96A) (Shutdown)

    Apple Watch - 42mm (0A3CB7E9-68C8-4F70-B59A-D72374ECE4C9) (Shutdown)

== Device Pairs ==

008867EE-00CB-4565-A18D-2CF26B44B3B8 (active, disconnected)

    Watch: Apple Watch - 38mm (F25D93AF-90E3-47E9-8476-FF2A6842B8C9) (Shutdown)

    Phone: iPhone 6 (06C2614B-FB3A-4CCB-8985-D1EB81FA72B3) (Shutdown)

E247E478-C5B3-4A27-A793-96088FFD37CC (active, disconnected)

    Watch: Apple Watch - 42mm (7BD59DE3-3934-4A3E-99CA-C91865B9660A) (Shutdown)

    Phone: iPhone 6 Plus (365C6809-B40B-4606-B909-E76A14776605) (Shutdown)

3CDDBEB2-443C-4F84-84B9-2775C927036F (active, disconnected)

    Watch: Apple Watch - 38mm (22B5BC0E-ACD6-490E-B95E-FB77ECCEE96A) (Shutdown)

    Phone: iPhone 6s (5752202B-E7A2-4B6C-9D7B-B211C2F54654) (Shutdown)

6ABB333A-C446-4106-9FD2-1C4DB8F7F4BC (active, disconnected)

    Watch: Apple Watch - 42mm (0A3CB7E9-68C8-4F70-B59A-D72374ECE4C9) (Shutdown)

    Phone: iPhone 6s Plus (989606C6-1BE4-425F-9497-43D9D37F0BCC) (Shutdown)

61.29s$ curl -s https://raw.githubusercontent.com/atom/ci/master/build-package.sh | sh

Downloading latest Atom release...

Using Atom version:

Atom    : 1.16.0

Electron: 1.3.13

Chrome  : 52.0.2743.82

Node    : 6.5.0

Using APM version:

apm  1.16.1

npm  3.10.5

node 6.9.5 x64

python 2.7.12

git 2.10.0

Downloading package dependencies...

Installing modules ✓

Running specs...

..........


Finished in 1.502 seconds

10 tests, 26 assertions, 0 failures, 0 skipped




The command "curl -s https://raw.githubusercontent.com/atom/ci/master/build-package.sh | sh" exited with 0.


Done. Your build exited with 0.

/Users/travis/.travis/job_stages: line 150: shell_session_update: command not found


    
