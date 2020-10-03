---
title: Snippets
---
### Snippets
Snippets are an incredibly powerful way to quickly generate commonly needed code syntax from a shortcut.

The idea is that you can type something like `habtm` and then press the <kbd class="platform-all">Tab</kbd> key and it will expand into `has_and_belongs_to_many`.

Many Core and Community packages come bundled with their own snippets that are specific to it. For example, the `language-html` package that provides support for HTML syntax highlighting and grammar comes with dozens of snippets to create many of the various HTML tags you might want to use. If you create a new HTML file in Atom, you can type `html` and then press <kbd class="platform-all">Tab</kbd> and it will expand to:

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>

  </body>
</html>
```

It will also position the cursor in the `lang` attribute value so you can edit it if necessary. Many snippets have multiple focus points that you can move through with the <kbd class="platform-all">Tab</kbd> key as well - for instance, in the case of this HTML snippet, after the cursor is placed in the `lang` attribute value, you can continue pressing <kbd class="platform-all">Tab</kbd> and the cursor will move to the `dir` attribute value, then to the middle of the `title` tag, then finally to the middle of the `body` tag.

To see all the available snippets for the file type that you currently have open, choose "Snippets: Available" in the Command Palette.

![View all available snippets](../../images/snippets.png "View all available snippets")

You can also use fuzzy search to filter this list down by typing in the selection box. Selecting one of them will execute the snippet where your cursor is (or multiple cursors are).

#### Creating Your Own Snippets

So that's pretty cool, but what if there is something the language package didn't include or something that is custom to the code you write? Luckily it's incredibly easy to add your own snippets.

There is a text file in your <span class="platform-mac platform-linux">`~/.atom`</span><span class="platform-windows">`%USERPROFILE%\.atom`</span> directory called `snippets.cson` that contains all your custom snippets that are loaded when you launch Atom. You can also easily open up that file by selecting the <span class="platform-mac">_Atom > Snippets_</span><span class="platform-linux">_Edit > Snippets_</span><span class="platform-windows">_File > Snippets_</span> menu.

##### Snippet Format

So let's look at how to write a snippet. The basic snippet format looks like this:

```coffee
'.source.js':
  'console.log':
    'prefix': 'log'
    'body': 'console.log(${1:"crash"});$2'
```

The leftmost keys are the selectors where these snippets should be active. The easiest way to determine what this should be is to go to the language package of the language you want to add a snippet for and look for the "Scope" string.

For example, if we wanted to add a snippet that would work for Java files, we would look up the `language-java` package in our Settings view and we can see the Scope is `source.java`. Then the top level snippet key would be that prepended by a period (like a CSS class selector would do).

![Finding the selector scope for a snippet](../../images/snippet-scope.png "Finding the selector scope for a snippet")

The next level of keys are the snippet names. These are used for describing the snippet in a more readable way in the snippet menu. You can name them whatever you want.

Under each snippet name is a `prefix` that should trigger the snippet and a `body` to insert when the snippet is triggered.

Each `$` followed by a number is a tab stop. Tab stops are cycled through by pressing <kbd class="platform-all">Tab</kbd> once a snippet has been triggered.

Tab stops with the same number will create multiple cursors.

The above example adds a `log` snippet to JavaScript files that would expand to:

```javascript
console.log("crash");
```

The string `"crash"` would be initially selected and pressing tab again would place the cursor after the `;`

{{#warning}}

Snippet keys, unlike CSS selectors, can only be repeated once per level. If there are duplicate keys at the same level, then only the last one will be read. See [Configuring with CSON](/using-atom/sections/basic-customization/#configuring-with-cson) for more information.

{{/warning}}

##### Multi-line Snippet Body

You can also use [CoffeeScript multi-line syntax](http://coffeescript.org/#strings) using `"""` for larger templates:

```coffee
'.source.js':
  'if, else if, else':
    'prefix': 'ieie'
    'body': """
      if (${1:true}) {
        $2
      } else if (${3:false}) {
        $4
      } else {
        $5
      }
    """
```

As you might expect, there is a snippet to create snippets. If you open up a snippets file and type `snip` and then press <kbd class="platform-all">Tab</kbd>, you will get the following text inserted:

```coffee
'.source.js':
  'Snippet Name':
    'prefix': 'hello'
    'body': 'Hello World!'
```

:boom: just fill that bad boy out and you have yourself a snippet. As soon as you save the file, Atom should reload the snippets and you will immediately be able to try it out.

##### Multiple Snippets per Source

You can see below the format for including multiple snippets for the same scope in your `snippets.cson` file. Just include the snippet name, prefix, and body keys for additional snippets inside the scope key:

```coffee
'.source.gfm':
  'Hello World':
    'prefix': 'hewo'
    'body': 'Hello World!'

  'Github Hello':
    'prefix': 'gihe'
    'body': 'Octocat says Hi!'

  'Octocat Image Link':
    'prefix': 'octopic'
    'body': '![GitHub Octocat](https://assets-cdn.github.com/images/modules/logos_page/Octocat.png)'
```

Again, see [Configuring with CSON](/using-atom/sections/basic-customization/#configuring-with-cson) for more information on CSON key structure and non-repeatability.

#### More Info

The snippets functionality is implemented in the [snippets](https://github.com/atom/snippets) package.

For more examples, see the snippets in the [language-html](https://github.com/atom/language-html/blob/master/snippets/language-html.cson) and [language-javascript](https://github.com/atom/language-javascript/blob/master/snippets/language-javascript.cson) packages.
