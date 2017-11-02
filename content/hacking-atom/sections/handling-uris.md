---
title: Handling URIs
---
### Handling URIs

Beginning in Atom 1.23, packages have the ability to handle special URIs triggered from the system; for example, a package named `my-package` can register itself to handle any URI starting with `atom://my-package/`.

{{#warning}}

**Warning:** Handling URIs triggered from other applications, like a web browser, is a powerful tool, but also one that can be jarring. You should shape your package's user experience to handle this well. In general, you should **avoid taking direct action on behalf of a user**. For example, a URI handler that immediately installs a package is too invasive, but a URI handler that shows the package's pane in the settings view is useful. A URI handler that begins to clone a repo is overly aggressive, but a URI handler that *prompts* the user to clone a repo is okay.

Any package with a URI handler that we feel violates this guideline is subject to removal from the Atom package registry at our discretion.

{{/warning}}

#### Modifying your `package.json`

The first step to handling URIs from your package is to modify its `package.json` file. You should add a new key called `uriHandler`, and its value should be an object.

The `uriHandler` object *must* contain a key called `method` with a string value that tells Atom which method in your package to call when a URI needs to be handled. The object can *optionally* include a key called `deferActivation` which can be set to the boolean `false` to prevent Atom from deferring activation of your package — see more below.

For example, if we want our package `my-package` to handle URIs with a method on our package's main module called `handleURI`, we could add the following to our `package.json`:

```json
"uriHandler": {
  "method": "handleURI"
}
```

#### Modifying your Main Module

Now that we've told Atom that we want our package to handle URIs beginning with `atom://my-package/` via our `handleURI` method, we need to actually write this method. Atom passes two arguments to your URI handler method; the first one is the fully-parsed URI plus query string, [parsed with Node's `url.parse(uri, true)`](https://nodejs.org/api/url.html#url_url_parse_urlstring_parsequerystring_slashesdenotehost). The second argument is the raw, string URI; this is normally not needed since the first argument gives you structured information about the URI.

Here's a sample package, written in JavaScript, that handles URIs with the `package.json` configuration we saw above.

```js
export default {
  activate () {
    // normal activation code here
  },

  handleURI (parsedUri) {
    console.log(parsedUri)
  }
}
```

When Atom handles, for example, the URI `atom://my-package/my/test/url?value=42&other=false`, the package would log out something like the following:

```js
{
  protocol: 'atom:',
  slashes: true,
  auth: null,
  host: 'my-package',
  port: null,
  hostname: 'my-package',
  hash: null,
  search: '?value=true&other=false',
  query: { value: '42', other: 'false' },
  pathname: '/my/test/url',
  path: '/my/test/url?value=true&other=false',
  href: 'atom://my-package/my/test/url?value=true&other=false'
}
```

Notice that the query string arguments are available in the `query` property, but are strings — you'll have to convert to other native types yourself.

#### Controlling Activation Deferral

For performance reasons, adding a `uriHandler` entry to your package's `package.json` will enable *deferred activation*. This means that Atom will not activate your package until it has a URI for it to handle — it will then activate your package and then immediately call the URI handler method. If you want to disable the deferred activation, ensuring your package is activated upon startup, you can add `"deferActivation": false` to the URI handler config. For example,

```json
"uriHandler": {
  "method": "handleURI",
  "deferActivation": false
}
```

Before doing this, make sure your package actually needs to be activated immediately — disabling deferred activation means Atom takes longer to start since it has to activate all packages without deferred activation.

#### Linux Support

Because URI handling is different across operating systems and distributions, there is no built-in URI handler support for Atom on Linux. If you want to configure URI handling on your system yourself, then you should configure `atom:` protocol URI's to trigger atom with the `--uri-handler` flag; for example, the URI `atom://test/uri` should launch Atom via `atom --uri-handler atom://test/uri`.
