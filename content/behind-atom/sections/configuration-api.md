---
title: Configuration API
---
### Configuration API

#### Reading Config Settings

If you are writing a package that you want to make configurable, you'll need to read config settings via the `atom.config` global. You can read the current value of a namespaced config key with `atom.config.get`:

```javascript
// read a value with `config.get`
if (atom.config.get("editor.showInvisibles")) {
  this.showInvisibles()
}
```

Or you can subscribe via `atom.config.observe` to track changes from any view object.

```javascript
const {View} = require('space-pen')

class MyView extends View {
  function attached() {
    this.fontSizeObserveSubscription =
      atom.config.observe('editor.fontSize', (newValue, {previous}) => {
        this.adjustFontSize(newValue)
      })
  }

  function detached() {
    this.fontSizeObserveSubscription.dispose()
  }
}
```

The `atom.config.observe` method will call the given callback immediately with the current value for the specified key path, and it will also call it in the future whenever the value of that key path changes. If you only want to invoke the callback the next time the value changes, use `atom.config.onDidChange` instead.

Subscription methods return [`Disposable`](https://atom.io/docs/api/latest/Disposable) objects that can be used to unsubscribe. Note in the example above how we save the subscription to the `@fontSizeObserveSubscription` instance variable and dispose of it when the view is detached. To group multiple subscriptions together, you can add them all to a [`CompositeDisposable`](https://atom.io/docs/api/latest/CompositeDisposable) that you dispose when the view is detached.

#### Writing Config Settings

The `atom.config` database is populated on startup from <span class="platform-mac platform-linux">`~/.atom/config.cson`</span><span class="platform-windows">`%USERPROFILE%\.atom\config.cson`</span>, but you can programmatically write to it with `atom.config.set`:

```javascript
// basic key update
atom.config.set("core.showInvisibles", true)
```

If you're exposing package configuration via specific key paths, you'll want to associate them with a schema in your package's main module. Read more about schemas in the [Config API documentation](https://atom.io/docs/api/latest/Config).
