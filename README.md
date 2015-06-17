# Atom Flight Manual

This is the Atom book. Everything you need to know in order to use and hack Atom is in this Flight Manual.

You can find this book online at: http://atom.io/docs/latest/

This book is open source under a Creative Commons license.

[![atom-cover](https://cloud.githubusercontent.com/assets/70/6442143/e84ba6b8-c0ed-11e4-994f-4aceb66a773c.png)](https://github.com/atom/docs/releases/latest)


## License

This book is published under the Creative Commons BY-NC-SA license. If you contribute to the work, you will have to agree to allow your content to be published under the self same license. Check out [the license file](LICENSE.asc) for more details.

## Current Progress

To check the current progress and planned content of the book, check out the [outline](outline.md). This is a good place to start if you're looking for something to add.

## How To Generate the Book

There are two ways to generate e-book content from this source code.

The easiest way is simply to let us do it. A robot is standing by to look for new work on the main branch and automatically build it for everyone. Automatic builds will be linked on atom.io as soon as they are built.

The other way to generate e-book files is to do so manually with Asciidoctor. If you run the following you _may_ actually get HTML, Epub, Mobi and PDF output files:

````
$ bundle install
$ bundle exec rake book:build
Converting to HTML...
-- HTML output at atom.html
Converting to EPub...
-- Epub output at atom.epub
Converting to Mobi (kf8)...
-- Mobi output at atom.mobi
Converting to PDF...
-- PDF  output at atom.pdf
````

This uses the `asciidoctor`, `asciidoctor-pdf` and `asciidoctor-epub` projects.

## Contributing

If you'd like to help out by making a change, adding content or improving something, take a look at the [contributor's guide](CONTRIBUTING.md).

## Maintainers

These people are currently maintaining the book and will be responsible for content direction and PR merging.

- [@schacon](https://github.com/schacon)
