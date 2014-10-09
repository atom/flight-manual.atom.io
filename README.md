# Atom Long-Form Documentation

This document will serve as an outline and table of contents to organize our documentation effort. The first section is a top-down outline that attempts to capture the structure we want our docs to take. The second section is a flatter, less organized list of task-focused topics bucketed by persona. Feel free to send us pull requests with ideas. Note that pull requests editing the more loosely organized bottom-up section will be easier to merge.

## Table Of Contents (Top-Down)

> `-` bullets indicate headings
> `*` bullets indicate links

- Atom usage
  * command palette
  * settings view
  * packages (languages)
  * themes
  * running atom from the command line
  * find and replace
  * projects (tree view)
  * key bindings
  * working with git
  * editing markdown
  * split panes
  * editing text efficiently (snippets, autocomplete, multi-cursors)
* Writing packages
  * Creating theme
  * Creating a package
    * Getting started
      * package generator - wizards for kinds
      * structure
      * lifecycle
      * how to publish
    * Kinds of packages
      * add something to status bar
      * add a panel
      * pane item
      * modal panel
      * basic editor command
      * decorate editor/gutter
      * modal decorations
    * Common tasks
      * configure my package
      * add application menu/context menu
      * get all the editors
      * understand when the active editor changes
      * background tasks
      * subscribing to events
      * subscribing to commands
      * messages to the user
      * dialogs
      * serialization
      * converting textmate bundles
    * Best practices (patterns and anti-patterns)
      * aggregating subscriptions
      * view best practices
      * don't make a slow package
* Creating themes
* Contributing
  * To packages
    * Cloning and apm linking
    * apm install/update
    * Native modules
    * Running specs
    * Link to sending a pull request
  * To core
    * Opening issues
    * Roadmaps
    * Where is the code?
    * Forum
    * Building Atom
    * Technologies it uses
      * Node
      * Atom-shell
      * apm
      * npm
    * Coding conventions
    * [x] Commit conventions
* Reference Manual

## Persona-Based Topic Lists (Bottom-Up)

### New User

What are the most important things for a new user to know?

* command palette
* settings view
* packages (languages)
* themes
* running atom from the command line
* find and replace
* projects (tree view)
* key bindings
* working with git
* editing markdown
* split panes
* editing text efficiently (snippets, autocomplete, multi-cursors)
* best practices
  * don't add duplicate keys to your cson/json files

#### Coming From TextMate?
#### Coming From Sublime?
#### Coming From Emacs?
#### Coming From Vim?

## New Theme Author

## First-Time Package Author

* package generator - wizards for kinds
* structure
  * code organization (where do i put shit?)
  * keymaps
  * commands
  * menus
  * stylesheets
* lifecycle
  * activation/deactivation
  * serialization
* how to publish

## Package Author

* kinds of packages
  * add something to status bar
  * add a panel
  * pane item
  * modal panel
  * basic editor command
  * decorate editor/gutter
  * modal decorations

* configure my package
* add application menu/context menu
* get all the editors
* understand when the active editor changes
* background tasks
* subscribing to events
* subscribing to commands
* messages to the user
* dialogs
* serialization
* converting textmate bundles

* best practices (patterns/anti-patterns)
* aggregating subscriptions
* view best practices
* don't make a slow package

## Contributor to Existing Package

## Contributing to Core

## New Grammar Author
