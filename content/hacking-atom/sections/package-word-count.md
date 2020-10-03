---
title: "Package: Word Count"
---
### Package: Word Count

Let's get started by writing a very simple package and looking at some of the tools needed to develop one effectively. We'll start by writing a package that tells you how many words are in the current buffer and display it in a small modal window.

#### Package Generator

The simplest way to start a package is to use the built-in package generator that ships with Atom. As you might expect by now, this generator is itself a separate package implemented in [package-generator](https://github.com/atom/package-generator).

You can run the generator by invoking the command palette and searching for "Generate Package". A dialog will appear asking you to name your new project. Name it `your-name-word-count`. Atom will then create that directory and fill it out with a skeleton project and link it into your <span class="platform-mac platform-linux">`~/.atom/packages`</span><span class="platform-windows">`%USERPROFILE%\.atom\packages`</span> directory so it's loaded when you launch your editor next time.

{{#note}}

**Note:** You may encounter a situation where your package is not loaded. That is because a new package using the same name as an actual package hosted on [atom.io](https://atom.io/packages) (e.g. "wordcount" and "word-count") is not being loaded as you expected. If you follow our suggestion above of using the `your-name-word-count` package name, you *should* be safe :grinning:

{{/note}}

![Basic generated Atom package](../../images/package.png)

You can see that Atom has created about a dozen files that make up the package. Let's take a look at each of them to get an idea of how a package is structured, then we can modify them to get our word count functionality.

The basic package layout is as follows:

```
my-package/
├─ grammars/
├─ keymaps/
├─ lib/
├─ menus/
├─ spec/
├─ snippets/
├─ styles/
├─ index.js
└─ package.json
```

Not every package will have (or need) all of these directories and the package generator doesn't create `snippets` or `grammars`. Let's see what some of these are so we can start messing with them.

##### `package.json`

Similar to [Node modules](https://en.wikipedia.org/wiki/Npm_(software)), Atom packages contain a `package.json` file in their top-level directory. This file contains metadata about the package, such as the path to its "main" module, library dependencies, and manifests specifying the order in which its resources should be loaded.

In addition to some of the regular [Node `package.json` keys](https://docs.npmjs.com/files/package.json) available, Atom `package.json` files have their own additions.

* `main`: the path to the JavaScript file that's the entry point to your package. If this is missing, Atom will default to looking for an `index.coffee` or `index.js`.
* `styles`: an Array of Strings identifying the order of the
style sheets your package needs to load. If not specified, style sheets in the `styles` directory are added alphabetically.
* `keymaps`: an Array of Strings identifying the order of the key mappings your package needs to load. If not specified, mappings in the `keymaps` directory are added alphabetically.
* `menus`: an Array of Strings identifying the order of the menu mappings your package needs to load. If not specified, mappings in the `menus` directory are added alphabetically.
* `snippets`: an Array of Strings identifying the order of the snippets your package needs to load. If not specified, snippets in the `snippets` directory are added alphabetically.
* `activationCommands`: an Object identifying commands that trigger your package's activation. The keys are CSS selectors, the values are Arrays of Strings identifying the command. The loading of your package is delayed until one of these events is triggered within the associated scope defined by the CSS selector. If not specified, the `activate()` method of your main export will be called when your package is loaded.
* `activationHooks`: an Array of Strings identifying hooks that trigger your package's activation. The loading of your package is delayed until one of these hooks are triggered. Currently, there are three activation hooks:
  * `core:loaded-shell-environment` for when Atom has finished loading the shell environment variables
  * `scope.name:root-scope-used` for when a file is opened from the specified language (e.g. `source.ruby:root-scope-used`)
  * `language-package-name:grammar-used` for when a specific language package is used (e.g., `my-special-language-javascript:grammar-used`)
* `workspaceOpeners`: An Array of Strings identifying URIs that trigger your package's activation. For example, say your package registers a custom opener for `atom://my-custom-panel`. By including that string in `workspaceOpeners`, your package will defer its activation until that URI is opened.

The `package.json` in the package we've just generated looks like this currently:

```json
{
  "name": "your-name-word-count",
  "main": "./lib/your-name-word-count",
  "version": "0.0.0",
  "description": "A short description of your package",
  "activationCommands": {
    "atom-workspace": "your-name-word-count:toggle"
  },
  "repository": "https://github.com/atom/your-name-word-count",
  "license": "MIT",
  "engines": {
    "atom": ">=1.0.0 <2.0.0"
  },
  "dependencies": {
  }
}
```

If you wanted to use activationHooks, you might have:

```json
{
  "name": "your-name-word-count",
  "main": "./lib/your-name-word-count",
  "version": "0.0.0",
  "description": "A short description of your package",
  "activationHooks": ["language-javascript:grammar-used", "language-coffee-script:grammar-used"],
  "repository": "https://github.com/atom/your-name-word-count",
  "license": "MIT",
  "engines": {
    "atom": ">=1.0.0 <2.0.0"
  },
  "dependencies": {
  }
}
```

One of the first things you should do is ensure that this information is filled out. The name, description, repository URL the project will be at, and the license can all be filled out immediately. The other information we'll get into more detail on as we go.

{{#warning}}

**Warning:** Do not forget to update the repository URL. The one generated for you is invalid by design and will prevent you from publishing your package until updated.

{{/warning}}

##### Source Code

If you want to extend Atom's behavior, your package should contain a single top-level module, which you export from whichever file is indicated by the `main` key in your `package.json` file. In the package we just generated, the main package file is `lib/your-name-word-count.js`. The remainder of your code should be placed in the `lib` directory, and required from your top-level file. If the `main` key is not in your `package.json` file, it will look for `index.js` or `index.coffee` as the main entry point.

Your package's top-level module is a singleton object that manages the lifecycle of your extensions to Atom. Even if your package creates ten different views and appends them to different parts of the DOM, it's all managed from your top-level object.

Your package's top-level module can implement the following basic methods:

* `activate(state)`: This **optional** method is called when your package is activated. It is passed the state data from the last time the window was serialized if your module implements the `serialize()` method. Use this to do initialization work when your package is started (like setting up DOM elements or binding events). If this method returns a promise the package will be considered loading until the promise resolves (or rejects).
* `initialize(state)`: (Available in Atom 1.14 and above) This **optional** method is similar to `activate()` but is called earlier. Whereas activation occurs after the workspace has been deserialized (and can therefore happen after [your package's deserializers](/behind-atom/sections/serialization-in-atom/#serialization-methods) have been called), `initialize()` is guaranteed to be called before everything. Use `activate()` if you want to be sure that the workspace is ready; use `initialize()` if you need to do some setup prior to your deserializers or view providers being invoked.
* `serialize()`: This **optional** method is called when the window is shutting down, allowing you to return JSON to represent the state of your component. When the window is later restored, the data you returned is passed to your module's `activate` method so you can restore your view to where the user left
off.
* `deactivate()`: This **optional** method is called when the window is shutting down and when the package is disabled. If your package is watching any files or holding external resources in any other way, release them here. You should also dispose of all subscriptions you're holding on to.

##### Style Sheets

Style sheets for your package should be placed in the `styles` directory. Any style sheets in this directory will be loaded and attached to the DOM when your package is activated. Style sheets can be written as CSS or [Less](http://lesscss.org), but Less is recommended.

Ideally, you won't need much in the way of styling. Atom provides a standard set of components which define both the colors and UI elements for any package that fits into Atom seamlessly. You can view all of Atom's UI components by opening the styleguide: open the command palette <kbd class="platform-mac">Cmd+Shift+P</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+P</kbd> and search for `styleguide`, or type <kbd class="platform-mac">Cmd+Ctrl+Shift+G</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+G</kbd>.

If you _do_ need special styling, try to keep only structural styles in the package style sheets. If you _must_ specify colors and sizing, these should be taken from the active theme's [ui-variables.less](https://github.com/atom/atom-dark-ui/blob/master/styles/ui-variables.less).

An optional `styleSheets` array in your `package.json` can list the style sheets by name to specify a loading order; otherwise, style sheets are loaded alphabetically.

##### Keymaps

You can provide key bindings for commonly used actions for your extension, especially if you're also adding a new command. In our new package, we have a keymap filled in for us already in the `keymaps/your-name-word-count.json` file:

```javascript
{
  "atom-workspace": {
    "ctrl-alt-o": "your-name-word-count:toggle"
  }
}
```

This means that if you press <kbd class="platform-all">Alt+Ctrl+O</kbd>, our package will run the `your-name-word-count:toggle` command. We'll look at that code next, but if you want to change the default key mapping, you can do that in this file.

Keymaps are placed in the `keymaps` subdirectory. By default, all keymaps are loaded in alphabetical order. An optional `keymaps` array in your `package.json` can specify which keymaps to load and in what order.

Keybindings are executed by determining which element the keypress occurred on. In the example above, the `your-name-word-count:toggle` command is executed when pressing <kbd class="platform-all">Alt+Ctrl+O</kbd> on the `atom-workspace` element. Because the `atom-workspace` element is the parent of the entire Atom UI, this means the key combination will work anywhere in the application.

We'll cover more advanced keybinding stuff a bit later in [Keymaps in Depth](/behind-atom/sections/keymaps-in-depth/).

##### Menus

Menus are placed in the `menus` subdirectory. This defines menu elements like what pops up when you right click a context-menu or would go in the application menu to trigger functionality in your plugin.

By default, all menus are loaded in alphabetical order. An optional `menus` array in your `package.json` can specify which menus to load and in what order.

###### Application Menu

It's recommended that you create an application menu item under the _Packages_ menu for common actions with your package that aren't tied to a specific element. If we look in the `menus/your-name-word-count.json` file that was generated for us, we'll see a section that looks like this:

```javascript

"menu": [
  {
    "label": "Packages",
    "submenu": [
      {
        "label": "Word Count",
        "submenu": [
          {
            "label": "Toggle",
            "command": "your-name-word-count:toggle"
          }
        ]
      }
    ]
  }
]

```

This section puts a "Toggle" menu item under a menu group named "Your Name Word Count" in the "Packages" menu.

![Application Menu Item](../../images/menu.png)

When you select that menu item, it will run the `your-name-word-count:toggle` command, which we'll look at in a bit.

The menu templates you specify are merged with all other templates provided by other packages in the order which they were loaded.

###### Context Menu

It's recommended to specify a context menu item for commands that are linked to specific parts of the interface. In our `menus/your-name-word-count.json` file, we can see an auto-generated section that looks like this:

```javascript
"context-menu": {
    "atom-text-editor": [
      {
        "label": "Toggle your-name-word-count",
        "command": "your-name-word-count:toggle"
      }
    ]
  }
```

This adds a "Toggle Word Count" menu option to the menu that pops up when you right-click in an Atom text editor pane.

![Context Menu Entry](../../images/context-menu.png)

When you click that it will again run the `your-name-word-count:toggle` method in your code.

Context menus are created by determining which element was selected and then adding all of the menu items whose selectors match that element (in the order which they were loaded). The process is then repeated for the elements until reaching the top of the DOM tree.

You can also add separators and submenus to your context menus. To add a submenu, provide a `submenu` key instead of a command. To add a separator, add an item with a single `type: 'separator'` key/value pair. For instance, you could do something like this:

```javascript
{
  "context-menu": {
    "atom-workspace": [
      {
        "label": "Text",
        "submenu": [
          {
            "label": "Inspect Element",
            "command": "core:inspect"
          },
          {
            "type": "separator"
          },
          {
            "label": "Selector All",
            "command": "core:select-all"
          },
          {
            "type": "separator"
          },
          {
            "label": "Deleted Selected Text",
            "command": "core:delete"
          }
        ]
      }
    ]
  }
}
```

#### Developing Our Package

Currently with the generated package we have, if we run that `your-name-word-count:toggle` command through the menu or the command palette, we'll get a dialog that says "The YourNameWordCount package is Alive! It's ALIVE!".

![Wordcount Package is Alive Dialog](../../images/toggle.png)

##### Understanding the Generated Code

Let's take a look at the code in our `lib` directory and see what is happening.

There are two files in our `lib` directory. One is the main file (`lib/your-name-word-count.js`), which is pointed to in the `package.json` file as the main file to execute for this package. This file handles the logic of the whole plugin.

The second file is a View class, `lib/your-name-word-count-view.js`, which handles the UI elements of the package. Let's look at this file first, since it's pretty simple.

```javascript
export default class YourNameWordCountView {

  constructor(serializedState) {
    // Create root element
    this.element = document.createElement('div');
    this.element.classList.add('your-name-word-count');

    // Create message element
    const message = document.createElement('div');
    message.textContent = 'The YourNameWordCount package is Alive! It\'s ALIVE!';
    message.classList.add('message');
    this.element.appendChild(message);
  }

  // Returns an object that can be retrieved when package is activated
  serialize() {}

  // Tear down any state and detach
  destroy() {
    this.element.remove();
  }

  getElement() {
    return this.element;
  }

}

```

Basically the only thing happening here is that when the View class is created, it creates a simple `div` element and adds the `your-name-word-count` class to it (so we can find or style it later) and then adds the "`Your Name Word Count package is Alive!`" text to it. There is also a `getElement` method which returns that `div`. The `serialize` and `destroy` methods don't do anything and we won't have to worry about that until another example.

Notice that we're simply using the basic browser DOM methods: `createElement()` and `appendChild()`.

The second file we have is the main entry point to the package. Again, because it's referenced in the `package.json` file. Let's take a look at that file.

```javascript
import YourNameWordCountView from './your-name-word-count-view';
import { CompositeDisposable } from 'atom';

export default {

  yourNameWordCountView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.yourNameWordCountView = new YourNameWordCountView(state.yourNameWordCountViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.yourNameWordCountView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'your-name-word-count:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.yourNameWordCountView.destroy();
  },

  serialize() {
    return {
      yourNameWordCountViewState: this.yourNameWordCountView.serialize()
    };
  },

  toggle() {
    console.log('YourNameWordCount was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
```

There is a bit more going on here.  First of all we can see that we are defining four methods. The only required one is `activate`. The `deactivate` and `serialize` methods are expected by Atom but optional. The `toggle` method is one Atom is not looking for, so we'll have to invoke it somewhere for it to be called, which you may recall we do both in the `activationCommands` section of the `package.json` file and in the action we have in the menu file.

The `deactivate` method simply destroys the various class instances we've created and the `serialize` method simply passes on the serialization to the View class. Nothing too exciting here.

The `activate` command does a number of things. For one, it is not called automatically when Atom starts up, it is first called when one of the `activationCommands` as defined in the `package.json` file are called. In this case, `activate` is only called the first time the `toggle` command is called. If nobody ever invokes the menu item or hotkey, this code is never called.

This method does two things. The first is that it creates an instance of the View class we have and adds the element that it creates to a hidden modal panel in the Atom workspace.

```javascript
this.yourNameWordCountView = new YourNameWordCountView(state.yourNameWordCountViewState);
this.modalPanel = atom.workspace.addModalPanel({
  item: this.yourNameWordCountView.getElement(),
  visible: false
});
```

We'll ignore the state stuff for now, since it's not important for this simple plugin. The rest should be fairly straightforward.

The next thing this method does is create an instance of the CompositeDisposable class so it can register all the commands that can be called from the plugin so other plugins could subscribe to these events.

```javascript
// Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
this.subscriptions = new CompositeDisposable();

// Register command that toggles this view
this.subscriptions.add(atom.commands.add('atom-workspace', {
  'your-name-word-count:toggle': () => this.toggle()
}));
```

Next we have the `toggle` method. This method simply toggles the visibility of the modal panel that we created in the `activate` method.

```javascript
toggle() {
  console.log('YourNameWordCount was toggled!');
  return (
    this.modalPanel.isVisible() ?
    this.modalPanel.hide() :
    this.modalPanel.show()
  );
}
```

This should be fairly simple to understand. We're looking to see if the modal element is visible and hiding or showing it depending on its current state.

##### The Flow

So, let's review the actual flow in this package.

1. Atom starts up
1. Atom starts loading packages
1. Atom reads your `package.json`
1. Atom loads keymaps, menus, styles and the main module
1. Atom finishes loading packages
1. At some point, the user executes your package command `your-name-word-count:toggle`
1. Atom executes the `activate` method in your main module which sets up the UI by creating the hidden modal view
1. Atom executes the package command `your-name-word-count:toggle` which reveals the hidden modal view
1. At some point, the user executes the `your-name-word-count:toggle` command again
1. Atom executes the command which hides the modal view
1. Eventually, Atom is shut down which can trigger any serializations that your package has defined

{{#tip}}

**Tip:** Keep in mind that the flow will be slightly different if you choose not to use `activationCommands` in your package.

{{/tip}}

##### Counting the Words

So now that we understand what is happening, let's modify the code so that our little modal box shows us the current word count instead of static text.

We'll do this in a very simple way. When the dialog is toggled, we'll count the words right before displaying the modal. So let's do this in the `toggle` command.  If we add some code to count the words and ask the view to update itself, we'll have something like this:

```javascript
toggle() {
  if (this.modalPanel.isVisible()) {
    this.modalPanel.hide();
  } else {
    const editor = atom.workspace.getActiveTextEditor();
    const words = editor.getText().split(/\s+/).length;
    this.yourNameWordCountView.setCount(words);
    this.modalPanel.show();
  }
}
```

Let's look at the 3 lines we've added. First we get an instance of the current editor object (where our text to count is) by calling [`atom.workspace.getActiveTextEditor()`](https://atom.io/docs/api/latest/Workspace#instance-getActiveTextEditor).

Next we get the number of words by calling [`getText()`](https://atom.io/docs/api/latest/TextEditor#instance-getText) on our new editor object, then splitting that text on whitespace with a regular expression and then getting the length of that array.

Finally, we tell our view to update the word count it displays by calling the `setCount()` method on our view and then showing the modal again. Since that method doesn't yet exist, let's create it now.

We can add this code to the end of our `your-name-word-count-view.js` file:

```javascript
setCount(count) {
  const displayText = `There are ${count} words.`;
  this.element.children[0].textContent = displayText;
}
```

Pretty simple! We take the count number that was passed in and place it into a string that we then stick into the element that our view is controlling.

{{#note}}

**Note:** To see your changes, you'll need to reload the code. You can do this by reloading the window (The `window:reload` command in the Command Palette). A common practice is to have two Atom windows, one for developing your package, and one for testing and reloading.

{{/note}}

![Word Count Working](../../images/wordcount.png)

#### Basic Debugging

You'll notice a few `console.log` statements in the code. One of the cool things about Atom being built on Chromium is that you can use some of the same debugging tools available to you that you have when doing web development.

To open up the Developer Console, press <kbd class="platform-mac">Alt+Cmd+I</kbd><kbd class="platform-windows platform-linux">Ctrl+Shift+I</kbd>, or choose the menu option _View > Developer > Toggle Developer Tools_.

![Developer Tools Debugging](../../images/dev-tools.png)

From here you can inspect objects, run code and view console output just as though you were debugging a web site.

#### Testing

Your package should have tests, and if they're placed in the `spec` directory, they can be run by Atom.

Under the hood, [Jasmine v1.3](https://jasmine.github.io/1.3/introduction.html) executes your tests, so you can assume that any DSL available there is also available to your package.

##### Running Tests

Once you've got your test suite written, you can run it by pressing <kbd class="platform-mac">Alt+Cmd+Ctrl+P</kbd><kbd class="platform-windows platform-linux">Alt+Ctrl+P</kbd> or via the _View > Developer > Run Package Specs_ menu. Our generated package comes with an example test suite, so you can run this right now to see what happens.

![Spec Suite Results](../../images/spec-suite.png)

You can also use the `atom --test spec` command to run them from the command line. It prints the test output and results to the console and returns the proper status code depending on whether the tests passed or failed.

#### Summary

We've now generated, customized and tested our first plugin for Atom. Congratulations! Now let's go ahead and [publish](../publishing/) it so it's available to the world.
