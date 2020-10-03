---
title: Writing specs
---
### Writing Specs

We've looked at and written a few specs through the examples already. Now it's time to take a closer look at the spec framework itself. How exactly do you write tests in Atom?

Atom uses [Jasmine](https://jasmine.github.io/1.3/introduction.html) as its spec framework. Any new functionality should have specs to guard against regressions.

#### Create a New Spec

[Atom specs](https://github.com/atom/atom/tree/master/spec) and [package specs](https://github.com/atom/markdown-preview/tree/master/spec) are added to their respective `spec` directory. The example below creates a spec for Atom core.

##### Create a Spec File

Spec files **must** end with `-spec` so add `sample-spec.coffee` to the `spec` directory.

##### Add One or More `describe` Methods

The `describe` method takes two arguments, a description and a function. If the description explains a behavior it typically begins with `when`; if it is more like a unit test it begins with the method name.

```javascript
describe("when a test is written", function() {
  // contents
})
```

or

```javascript
describe("Editor::moveUp", function() {
  // contents
})
```

##### Add One or More `it` Methods

The `it` method also takes two arguments, a description and a function. Try and make the description flow with the `it` method. For example, a description of "this should work" doesn't read well as "it this should work". But a description of "should work" sounds great as "it should work".

```javascript
describe("when a test is written", function() {
  it("has some expectations that should pass", function() {
    // Expectations
  })
})
```

##### Add One or More Expectations

The best way to learn about expectations is to read the [Jasmine documentation](https://jasmine.github.io/1.3/introduction.html#section-Expectations) about them. Below is a simple example.

```javascript
describe("when a test is written", function() {
  it("has some expectations that should pass", function() {
    expect("apples").toEqual("apples")
    expect("oranges").not.toEqual("apples")
  })
})
```

###### Custom Matchers

In addition to the Jasmine's built-in matchers, Atom includes the following:

* [jasmine-jquery](https://github.com/velesin/jasmine-jquery)
* The `toBeInstanceOf` matcher is for the `instanceof` operator
* The `toHaveLength` matcher compares against the `.length` property
* The `toExistOnDisk` matcher checks if the file exists in the filesystem
* The `toHaveFocus` matcher checks if the element currently has focus
* The `toShow` matcher tests if the element is visible in the dom

These are defined in [spec/spec-helper.coffee](https://github.com/atom/atom/blob/master/spec/spec-helper.coffee).

#### Asynchronous Specs

Writing Asynchronous specs can be tricky at first. Some examples.

##### Promises

Working with promises is rather easy in Atom. You can use our `waitsForPromise` function.

```javascript
describe("when we open a file", function() {
  it("should be opened in an editor", function() {
    waitsForPromise(function() {
      atom.workspace.open('c.coffee').then(editor => expect(editor.getPath()).toContain('c.coffee'))
    })
  })
})
```

This method can be used in the `describe`, `it`, `beforeEach` and `afterEach` functions.

```javascript
describe("when we open a file", function() {
  beforeEach(function() {
    waitsForPromise(() => atom.workspace.open('c.coffee'))
  })

  it("should be opened in an editor", function() {
     expect(atom.workspace.getActiveTextEditor().getPath()).toContain('c.coffee')
  })
})
```

If you need to wait for multiple promises use a new `waitsForPromise` function for each promise. (Caution: Without `beforeEach` this example will fail!)

```javascript
describe("waiting for the packages to load", function() {
  beforeEach(function() {
    waitsForPromise(() => atom.workspace.open('sample.js'))

    waitsForPromise(() => atom.packages.activatePackage('tabs'))

    waitsForPromise(() => atom.packages.activatePackage('tree-view'))
  });

  it('should have waited long enough', function() {
    expect(atom.packages.isPackageActive('tabs')).toBe(true)
    expect(atom.packages.isPackageActive('tree-view')).toBe(true)
  })
})
```

`waitsForPromise` can take an additional object argument before the function. The object can have the following properties:

* `shouldReject` Whether the promise should reject or resolve (default: `false`)
* `timeout` The amount of time (in ms) to wait for the promise to be resolved or rejected (default: `process.env.CI ? 60000 : 5000`)
* `label` The label to display if promise times out (default: `'promise to be resolved or rejected'`)

```javascript
describe("when we open a file", function() {
  it("should be opened in an editor", function() {
    waitsForPromise({ shouldReject: false, timeout: 5000, label: 'promise to be resolved or rejected' }, () =>
      atom.workspace.open('c.coffee').then(editor => expect(editor.getPath()).toContain('c.coffee'))
    )
  })
})
```

##### Asynchronous Functions with Callbacks

Specs for asynchronous functions can be done using the `waitsFor` and `runs` functions. A simple example.

```javascript
describe("fs.readdir(path, cb)", function() {
  it("is async", function() {
    const spy = jasmine.createSpy('fs.readdirSpy')
    fs.readdir('/tmp/example', spy)

    waitsFor(() => spy.callCount > 0)

    runs(function() {
      const exp = [null, ['example.coffee']]

      expect(spy.mostRecentCall.args).toEqual(exp)
      expect(spy).toHaveBeenCalledWith(null, ['example.coffee'])
    })
  })
})
```

For a more detailed documentation on asynchronous tests please visit the [Jasmine documentation](https://jasmine.github.io/1.3/introduction.html#section-Asynchronous_Support).

#### Running Specs

Most of the time you'll want to run specs by triggering the `window:run-package-specs` command. This command is not only to run package specs, it can also be used to run Atom core specs when working on Atom itself. This will run all the specs in the current project's `spec` directory.

To run a limited subset of specs use the `fdescribe` or `fit` methods. You can use those to focus a single spec or several specs. Modified from the example above, focusing an individual spec looks like this:

```javascript
describe("when a test is written", function() {
  fit("has some expectations that should pass", function() {
    expect("apples").toEqual("apples")
    expect("oranges").not.toEqual("apples")
  })
})
```

##### Running on CI

It is now easy to run the specs in a CI environment like Travis and AppVeyor. See the [Travis CI For Your Packages](https://blog.atom.io/2014/04/25/ci-for-your-packages.html) and [AppVeyor CI For Your Packages](http://blog.atom.io/2014/07/28/windows-ci-for-your-packages.html) posts for more details.

##### Running via the Command Line

To run tests on the command line, run Atom with the `--test` flag followed by one or more paths to test files or directories. You can also specify a `--timeout` option, which will force-terminate your tests after a certain number of seconds have passed.

``` command-line
atom --test --timeout 60 ./test/test-1.js ./test/test-2.js
```

#### Customizing your test runner

{{#warning}}

**Warning:** This API is available as of 1.2.0-beta0, and it is experimental and subject to change. Test runner authors should be prepared to test their code against future beta releases until it stabilizes.

{{/warning}}

By default, package tests are run with Jasmine 1.3, which is outdated but can't be changed for compatibility reasons. You can specify your own custom test runner by including an `atomTestRunner` field in your `package.json`. Atom will require whatever module you specify in this field, so you can use a relative path or the name of a module in your package's dependencies.

Your test runner module must export a single function, which Atom will call within a new window to run your package's tests. Your function will be called with the following parameters:

* `testPaths` An array of paths to tests to run. Could be paths to files or directories.
* `buildAtomEnvironment` A function that can be called to construct an instance of the `atom` global. No `atom` global will be explicitly assigned, but you can assign one in your runner if desired. This function should be called with the following parameters:
  * `applicationDelegate` An object responsible for Atom's interaction with the browser process and host OS. Use `buildDefaultApplicationDelegate` for a default instance. You can override specific methods on this object to prevent or test these interactions.
  * `window` A window global.
  * `document` A document global.
  * `configDirPath` A path to the configuration directory (usually `~/.atom`).
  * `enablePersistence` A boolean indicating whether the Atom environment should save or load state from the file system. You probably want this to be `false`.
* `buildDefaultApplicationDelegate` A function that builds a default instance of the application delegate, suitable to be passed as the `applicationDelegate` parameter to `buildAtomEnvironment`.
* `logFile` An optional path to a log file to which test output should be logged.
* `headless` A boolean indicating whether or not the tests are being run from the command line via `atom --test`.
* `legacyTestRunner` This function can be invoked to run the legacy Jasmine runner, giving your package a chance to transition to a new test runner while maintaining a subset of its tests in the old environment.

Your function should return a promise that resolves to an exit code when your tests are finish running. This exit code will be returned when running your tests via the command line.
