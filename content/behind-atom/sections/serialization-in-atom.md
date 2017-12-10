---
title: Serialization in Atom
---
### Serialization in Atom

When a window is refreshed or restored from a previous session, the view and its associated objects are *deserialized* from a JSON representation that was stored during the window's previous shutdown. For your own views and objects to be compatible with refreshing, you'll need to make them play nicely with the serializing and deserializing.

#### Package Serialization Hook

Your package's main module can optionally include a `serialize` method, which will be called before your package is deactivated. You should return a JSON-serializable object, which will be handed back to you as an object argument to `activate` next time it is called. In the following example, the package keeps an instance of `MyObject` in the same state across refreshes.

```coffee-script
module.exports =
  activate: (state) ->
    @myObject =
      if state
        atom.deserializers.deserialize(state)
      else
        new MyObject("Hello")

  serialize: ->
    @myObject.serialize()
```

#### Serialization Methods

```coffee-script
class MyObject
  constructor: (@data) ->
  serialize: -> { deserializer: 'MyObject', data: @data }
```

##### `serialize()`

Objects that you want to serialize should implement `.serialize()`. This method should return a serializable object, and it must contain a key named `deserializer` whose value is the name of a registered deserializer that can convert the rest of the data to an object. It's usually just the name of the class itself.

##### Registering Deserializers

The other side of the coin is deserializers, whose job is to convert a state object returned from a previous call to `serialize` back into a genuine object.

###### `deserializers` in `package.json`

The preferred way to register deserializers is via your package's `package.json` file:

```json
{
  "name": "wordcount",
  ...
  "deserializers": {
    "MyObject": "deserializeMyObject"
  }
}
```

Here, the key (`"MyObject"`) is the name of the deserializer—the same string used by the `deserializer` field in the object returned by your `serialize()` method. The value (`"deserializeMyObject"`) is the name of a function in your main module that'll be passed the serialized data and will return a genuine object. For example, your main module might look like this:

```coffee-script
module.exports =
  deserializeMyObject: ({data}) -> new MyObject(data)
```

Now you can call the global `deserialize` method with state returned from `serialize`, and your class's `deserialize` method will be selected automatically.

###### atom.deserializers.add(klass)

An alternative is to use the `atom.deserializers.add` method with your class in order to make it available to the deserialization system. Usually this is used in conjunction with a class-level `deserialize` method:

```coffee-script
class MyObject
  atom.deserializers.add(this)

  @deserialize: ({data}) -> new MyObject(data)
  constructor: (@data) ->
  serialize: -> { deserializer: 'MyObject', data: @data }
```

While this used to be the standard method of registering a deserializer, the `package.json` method is now preferred since it allows Atom to defer loading and executing your code until it's actually needed.

#### Versioning

```coffee-script
class MyObject
  atom.deserializers.add(this)

  @version: 2
  @deserialize: (state) -> ...
  serialize: -> { version: @constructor.version, ... }
```

Your serializable class can optionally have a class-level `@version` property and include a `version` key in its serialized state. When deserializing, Atom will only attempt to call deserialize if the two versions match, and otherwise return undefined. We plan on implementing a migration system in the future, but this at least protects you from improperly deserializing old state.
