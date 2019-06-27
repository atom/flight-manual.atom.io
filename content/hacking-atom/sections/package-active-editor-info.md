---
title: "Package: Active Editor Info"
---
### Package: Active Editor Info

We saw in our [Word Count](/hacking-atom/sections/package-word-count/) package how we could show information in a modal panel. However, panels aren't the only way to extend Atom's UI—you can also add items to the workspace. These items can be dragged to new locations (for example, one of the docks on the edges of the window), and Atom will restore them the next time you open the project. This system is used by Atom's tree view, as well as by third party packages like [Nuclide](https://nuclide.io) for its console, debugger, outline view, and diagnostics (linter results).

For this package, we'll define a workspace item that tells us some information about our active text editor. The final package can be viewed at https://github.com/atom/active-editor-info.

#### Create the Package

To begin, press <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> to bring up the [Command Palette](https://github.com/atom/command-palette). Type "generate package" and select the "Package Generator: Generate Package" command, just as we did in [the section on package generation](/hacking-atom/sections/package-word-count/#package-generator). Enter `active-editor-info` as the name of the package.

#### Add an Opener

Now let's edit the package files to show our view in a workspace item instead of a modal panel. The way we do this is by registering an *opener* with Atom. Openers are just functions that accept a URI and return a view (if it's a URI that the opener knows about). When you call `atom.workspace.open()`, Atom will go through all of its openers until it finds one that can handle the URI you passed.

Let's open `lib/active-editor-info.js` and edit our `activate()` method to register an opener:

```js
'use babel';

import ActiveEditorInfoView from './active-editor-info-view';
import {CompositeDisposable, Disposable} from 'atom';

export default {

  subscriptions: null,

  activate(state) {
    this.subscriptions = new CompositeDisposable(
      // Add an opener for our view.
      atom.workspace.addOpener(uri => {
        if (uri === 'atom://active-editor-info') {
          return new ActiveEditorInfoView();
        }
      }),

      // Register command that toggles this view
      atom.commands.add('atom-workspace', {
        'active-editor-info:toggle': () => this.toggle()
      }),

      // Destroy any ActiveEditorInfoViews when the package is deactivated.
      new Disposable(() => {
        atom.workspace.getPaneItems().forEach(item => {
          if (item instanceof ActiveEditorInfoView) {
            item.destroy();
          }
        });
      })
    );
  },

  deactivate() {
    this.subscriptions.dispose();
  },

  toggle() {
    console.log('Toggle it!')
  }

};
```

You'll notice we also removed the `activeEditorInfoView` property and the `serialize()` method. That's because, with workspace items, it's possible to have more than one instance of a given view. Since each instance can have its own state, each should do its own serialization instead of relying on a package-level `serialize()` method. We'll come back to that later.

You probably also noticed that our `toggle()` implementation just logs the text "Toggle it!" to the console. Let's make it actually toggle our view:

```js
  toggle() {
    atom.workspace.toggle('atom://active-editor-info');
  }
```

#### Updating the View

Atom uses the same view abstractions everywhere, so we can almost use the generated ActiveEditorInfoView class as-is. We just need to add two small methods:

```js
  getTitle() {
    // Used by Atom for tab text
    return 'Active Editor Info';
  }

  getURI() {
    // Used by Atom to identify the view when toggling.
    return 'atom://active-editor-info';
  }
```

Now reload the window and run the "Active Editor Info: Toggle" command from the command palette! Our view will appear in a new tab in the center of the workspace. If you want, you can drag it into one of the docks. Toggling it again will then hide that dock. If you close the tab and run the toggle command again, it will appear in the last place you had it.

{{#note}}

We've repeated the same URI three times now. That's okay, but it's probably a good idea to define the URL in one place and then import it from that module wherever you need it.

{{/note}}

#### Constraining Our Item's Locations

The purpose of our view is to show information about the active text editor, so it doesn't really make sense to show our item in the center of the workspace (where the text editor will be). Let's add some methods to our view class to influence where its opened:

```js
  getDefaultLocation() {
    // This location will be used if the user hasn't overridden it by dragging the item elsewhere.
    // Valid values are "left", "right", "bottom", and "center" (the default).
    return 'right';
  }

  getAllowedLocations() {
    // The locations into which the item can be moved.
    return ['left', 'right', 'bottom'];
  }
```

Now our item will appear in the right dock initially and users will only be able to drag it to one of the other docks.

#### Show Active Editor Info

Now that we have our view all wired up, let's update it to show some information about the active text editor. Add this to the constructor:

```js
this.subscriptions = atom.workspace.getCenter().observeActivePaneItem(item => {
  if (!atom.workspace.isTextEditor(item)) {
    message.innerText = 'Open a file to see important information about it.';
    return;
  }
  message.innerHTML = `
    <h2>${item.getFileName() || 'untitled'}</h2>
    <ul>
      <li><b>Soft Wrap:</b> ${item.softWrapped}</li>
      <li><b>Tab Length:</b> ${item.getTabLength()}</li>
      <li><b>Encoding:</b> ${item.getEncoding()}</li>
      <li><b>Line Count:</b> ${item.getLineCount()}</li>
    </ul>
  `;
});
```

Now whenever you open a text editor in the center, the view will update with some information about it.

{{#warning}}

We use a template string here because it's simple and we have a lot of control over what's going into it, but this could easily result in the insertion of unwanted HTML if you're not careful. Sanitize your input and use the DOM API or a templating system when doing this for real.

{{/warning}}

Also, don't forget to clean up the subscription in the `destroy()` method:

```js
destroy() {
  this.element.remove();
  this.subscriptions.dispose();
}
```

#### Serialization

If you were to reload Atom now, you'd see that our item had disappeared. That's because we haven't told Atom how to serialize it yet. Let's do that now.

The first step is to implement a `serialize()` method on our ActiveEditorInfoView class. Atom will call the `serialize()` method on every item in the workspace periodically to save its state.

```js
  serialize() {
    return {
      // This is used to look up the deserializer function. It can be any string, but it needs to be
      // unique across all packages!
      deserializer: 'active-editor-info/ActiveEditorInfoView'
    };
  }
```

{{#note}}

All of our view's state is derived from the active text editor so we only need the `deserializer` field. If we had other state that we wanted to preserve across reloads, we would just add things to the object we're returning. Just make sure that they're JSON serializable!

{{/note}}

Next we need to register a deserializer function that Atom can use to recreate the real object when it starts up. The best way to do that is to add a "deserializers" object to our `package.json` file:

```json
{
  "name": "active-editor-info",
  ...
  "deserializers": {
    "active-editor-info/ActiveEditorInfoView": "deserializeActiveEditorInfoView"
  }
}
```

Notice that the key (`"active-editor-info/ActiveEditorInfoView"`) matches the string we used in our `serialize()` method above. The value (`"deserializeActiveEditorInfoView"`) refers to a function in our main module, which we still need to add. Go back to `active-editor-info.js` and do that now:

```js
  deserializeActiveEditorInfoView(serialized) {
    return new ActiveEditorInfoView();
  }
```

The value returned from our `serialize()` method will be passed to this function. Since our serialized object didn't include any state, we can just return a new ActiveEditorInfoView instance.

Reload Atom and toggle the view with the "Active Editor Info: Toggle" command. Then reload Atom again. Your view should be just where you left it!

#### Summary

In this section, we've made a toggleable workspace item whose placement can be controlled by the user. This could be helpful when creating all sorts of visual tools for working with code!
