---
title: Keymaps In-Depth
---
### Keymaps In-Depth

#### Structure of a Keymap File

Keymap files are encoded as JSON or CSON files containing nested hashes. They work much like style sheets, but instead of applying style properties to elements matching the selector, they specify the meaning of keystrokes on elements matching the selector. Here is an example of some bindings that apply when keystrokes pass through `atom-text-editor` elements:

{{#mac}}

```coffee
'atom-text-editor':
  'cmd-delete': 'editor:delete-to-beginning-of-line'
  'alt-backspace': 'editor:delete-to-beginning-of-word'
  'ctrl-A': 'editor:select-to-first-character-of-line'
  'ctrl-shift-e': 'editor:select-to-end-of-line'
  'cmd-left': 'editor:move-to-first-character-of-line'

'atom-text-editor:not([mini])':
  'cmd-alt-[': 'editor:fold-current-row'
  'cmd-alt-]': 'editor:unfold-current-row'
```

{{/mac}}

{{#windows}}

```coffee
'atom-text-editor':
  'ctrl-left': 'editor:move-to-beginning-of-word'
  'ctrl-right': 'editor:move-to-end-of-word'
  'ctrl-shift-left': 'editor:select-to-beginning-of-word'
  'ctrl-shift-right': 'editor:select-to-end-of-word'
  'ctrl-backspace': 'editor:delete-to-beginning-of-word'
  'ctrl-delete': 'editor:delete-to-end-of-word'

'atom-text-editor:not([mini])':
  'ctrl-alt-[': 'editor:fold-current-row'
  'ctrl-alt-]': 'editor:unfold-current-row'
```

{{/windows}}

{{#linux}}

```coffee
'atom-text-editor':
  'ctrl-left': 'editor:move-to-beginning-of-word'
  'ctrl-right': 'editor:move-to-end-of-word'
  'ctrl-shift-left': 'editor:select-to-beginning-of-word'
  'ctrl-shift-right': 'editor:select-to-end-of-word'
  'ctrl-backspace': 'editor:delete-to-beginning-of-word'
  'ctrl-delete': 'editor:delete-to-end-of-word'

'atom-text-editor:not([mini])':
  'ctrl-alt-[': 'editor:fold-current-row'
  'ctrl-alt-]': 'editor:unfold-current-row'
```

{{/linux}}

Beneath the first selector are several keybindings, mapping specific key combinations to commands. When an element with the `atom-text-editor` class is focused and <kbd class="platform-mac">Alt+Backspace</kbd><kbd class="platform-windows platform-linux">Ctrl+Backspace</kbd> is pressed, a custom DOM event called `editor:delete-to-beginning-of-word` is emitted on the `atom-text-editor` element.

The second selector group also targets editors, but only if they don't have the `mini` attribute. In this example, the commands for code folding don't really make sense on mini-editors, so the selector restricts them to regular editors.

##### Key Combinations

Key combinations express one or more keys combined with optional modifier keys. For example: `ctrl-w v`, or `cmd-shift-up`. A key combination is composed of the following symbols, separated by a `-`. A key sequence can be expressed as key combinations separated by spaces.

| Type           | Examples     |
| :------------- | :------------- |
| Character literals | `a` `4` `$` |
| Modifier keys | `cmd` `ctrl` `alt` `shift` |
| Special keys | `enter` `escape` `backspace` `delete` `tab` `home` `end` `pageup` `pagedown` `left` `right` `up` `down` `space` |

##### Commands

Commands are custom DOM events that are triggered when a key combination or sequence matches a binding. This allows user interface code to listen for named commands without specifying the specific keybinding that triggers it. For example, the following code creates a command to insert the current date in an editor:

```javascript
atom.commands.add('atom-text-editor', {
  'user:insert-date': function (event) {
    const editor = this.getModel();
    return editor.insertText(new Date().toLocaleString());
  }
});
```

`atom.commands` refers to the global `CommandRegistry` instance where all commands are set and consequently picked up by the command palette.

When you are looking to bind new keys, it is often useful to use the Command Palette (<kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd>) to discover what commands are being listened for in a given focus context. Commands are "humanized" following a simple algorithm, so a command like `editor:fold-current-row` would appear as "Editor: Fold Current Row".

##### "Composed" Commands

A common question is, "How do I make a single keybinding execute two or more commands?" There isn't any direct support for this in Atom, but it can be achieved by creating a custom command that performs the multiple actions you desire and then creating a keybinding for that command. For example, let's say I want to create a "composed" command that performs a Select Line followed by Cut. You could add the following to your `init.coffee`:

```javascript
atom.commands.add('atom-text-editor', 'custom:cut-line', function () {
  const editor = this.getModel();
  editor.selectLinesContainingCursors();
  editor.cutSelectedText();
});
```

Then let's say we want to map this custom command to `alt-ctrl-z`, you could add the following to your keymap:

```coffee
'atom-text-editor':
  'alt-ctrl-z': 'custom:cut-line'
```

##### Specificity and Cascade Order

As is the case with CSS applying styles, when multiple bindings match for a single element, the conflict is resolved by choosing the most *specific* selector. If two matching selectors have the same specificity, the binding for the selector appearing later in the cascade takes precedence.

Currently, there's no way to specify selector ordering within a single keymap, because JSON objects do not preserve order. We handle cases where selector ordering is critical by breaking the keymap into separate files, such as `snippets-1.cson` and `snippets-2.cson`.

##### Selectors and Custom Packages

If a keybinding should only apply to a specific grammar, you can limit bindings to that grammar using the `data-grammar` attribute on the `atom-text-editor` element:

```coffee
"atom-text-editor[data-grammar='source example']":
  'ctrl-.': 'custom:custom-command'
```

While selectors can be applied to the entire editor by what grammar is associated with it, they cannot be applied to scopes defined within the grammar or to sub-elements of `atom-text-editor`.

#### Removing Bindings

When the keymap system encounters a binding with the `unset!` directive as its command, it will treat the current element as if it had no key bindings matching the current keystroke sequence and continue searching from its parent. For example, the following code removes the keybinding for `a` in the Tree View, which is normally used to trigger the `tree-view:add-file` command:

```coffee
'.tree-view':
  'a': 'unset!'
```

![Keybinding Resolver](../../images/keybinding.png)

But if some element above the Tree View had a keybinding for `a`, that keybinding would still execute even when the focus is inside the Tree View.

When the keymap system encounters a binding with the `abort!` directive as its command, it will stop searching for a keybinding. For example, the following code removes the keybinding for <kbd class='platform-mac'>Cmd+O</kbd><kbd class='platform-windows platform-linux'>Ctrl+O</kbd> when the selection is inside an editor pane:

{{#mac}}

```coffee
'atom-text-editor':
  'cmd-o': 'abort!'
```

{{/mac}}

{{#windows}}

```coffee
'atom-text-editor':
  'ctrl-o': 'abort!'
```

{{/windows}}

{{#linux}}

```coffee
'atom-text-editor':
  'ctrl-o': 'abort!'
```

{{/linux}}

But if you click inside the Tree View and press <kbd class='platform-mac'>Cmd+O</kbd><kbd class='platform-windows platform-linux'>Ctrl+O</kbd>, it will work.

#### Forcing Chromium's Native Keystroke Handling

If you want to force the native browser behavior for a given keystroke, use the `native!` directive as the command of a binding. This can be useful to enable the correct behavior in native input elements.  If you apply the `.native-key-bindings` class to an element, all the keystrokes typically handled by the browser will be assigned the `native!` directive.

{{#tip}}

**Tip:** Components and input elements may not correctly handle backspace and arrow keys without forcing this behavior.  If your backspace isn't working correctly inside of a component, add either the directive or the `.native-key-bindings` class.

{{/tip}}

#### Overloading Key Bindings

Occasionally, it makes sense to layer multiple actions on top of the same key binding. An example of this is the snippets package. Snippets are inserted by typing a snippet prefix such as `for` and then pressing <kbd class="platform-all">Tab</kbd>. Every time <kbd class="platform-all">Tab</kbd> is pressed, we want to execute code attempting to expand a snippet if one exists for the text preceding the cursor. If a snippet *doesn't* exist, we want <kbd class="platform-all">Tab</kbd> to actually insert whitespace.

To achieve this, the snippets package makes use of the `.abortKeyBinding()` method on the event object representing the `snippets:expand` command.

```javascript
// pseudo-code
editor.command('snippets:expand', e => {
  if (this.cursorFollowsValidPrefix()) {
    this.expandSnippet();
  } else {
    e.abortKeyBinding();
  }
});
```

When the event handler observes that the cursor does not follow a valid prefix, it calls `e.abortKeyBinding()`, telling the keymap system to continue searching for another matching binding.

#### Step-by-Step: How Keydown Events are Mapped to Commands

* A keydown event occurs on a *focused* element.
* Starting at the focused element, the keymap walks upward towards the root of
  the document, searching for the most specific CSS selector that matches the
  current DOM element and also contains a keystroke pattern matching the keydown
  event.
* When a matching keystroke pattern is found, the search is terminated and the
  pattern's corresponding command is triggered on the current element.
* If `.abortKeyBinding()` is called on the triggered event object, the search
  is resumed, triggering a binding on the next-most-specific CSS selector for
  the same element or continuing upward to parent elements.
* If no bindings are found, the event is handled by Chromium normally.

#### Overriding Atom's Keyboard Layout Recognition

Sometimes the problem isn't mapping the command to a key combination, the problem is that Atom doesn't recognize properly what keys you're pressing. This is due to [some limitations in how Chromium reports keyboard events](https://blog.atom.io/2016/10/17/the-wonderful-world-of-keyboards.html). But even this can be customized now.

You can add the following to your `init.coffee` to send <kbd class="platform-all">Ctrl+@</kbd> when you press <kbd class="platform-all">Ctrl+Alt+G</kbd>:

```coffee
atom.keymaps.addKeystrokeResolver ({event}) ->
  if event.code is 'KeyG' and event.altKey and event.ctrlKey and event.type isnt 'keyup'
    return 'ctrl-@'
```

Or if you've converted your init script to JavaScript:

```javascript
atom.keymaps.addKeystrokeResolver(({event}) => {
  if (event.code === 'KeyG' && event.altKey && event.ctrlKey && event.type !== 'keyup') {
    return 'ctrl-@';
  }
});
```

If you want to know the `event` for the keystroke you pressed you can paste the following script to your [developer tools console](https://flight-manual.atom.io/hacking-atom/sections/debugging/#check-for-errors-in-the-developer-tools)
```javascript
document.addEventListener('keydown', e => console.log(e), true);
```

This will print every keypress event in Atom to the console so you can inspect `KeyboardEvent.key` and `KeyboardEvent.code`.
