# Atom Flight Manual

This is the Atom book. Everything you need to know in order to use and hack Atom is in this Flight Manual.

You can find this book online (soon) at: http://atom.io/docs

This book is open source under a Creative Commons license.

## How To Generate the Book

There are two ways to generate e-book content from this source code.

The easiest way is simply to let us do it. A robot is standing by to look for new work on the main branch and automatically build it for everyone. Automatic builds will be linked on atom.io as soon as they are built.

The other way to generate e-book files is to do so manually with Asciidoctor. If you run the following you _may_ actually get HTML, Epub, Mobi and PDF output files:

----
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
----

This uses the `asciidoctor`, `asciidoctor-pdf` and `asciidoctor-epub` projects.

== Contributing

If you'd like to help out by making a change or contributing a translation, take a look at the link:CONTRIBUTING.md[contributor's guide].
