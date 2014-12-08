# Book Outline

* Introduction
  * [x] Why Atom
  * [x] Installing
  * [ ] Atom Basics
    * [x] Command Palette
    * [ ] Settings and preferences
      * Changing the default color scheme
      * Toggle soft wrap by default
    * [ ] Opening, modifying and saving files
      * Fuzzy-finder, modified file
      * buffers
    * [ ] Opening a project
* Using Atom
  * [ ] packages
    * finding and installing
    * settings, enabling
  * [ ] themes
    * finding and installing
    * switching
  * [ ] find and replace
  * [ ] selections
  * [ ] movement
    * tags/symbols
  * [ ] working with text
    * multiple cursors
    * line manipulation (move, indent, goto)
    * case, delete, transpose
    * recording and replaying
    * change encoding, grammar
    * bracket matching
    * whitespace
  * [ ] spell checking
  * [ ] bookmarks
  * [ ] projects (tree view)
    * toggle, rename, copy path, open
  * [ ] key bindings
  * [ ] folding
  * [ ] panes - splitting, loading, resizing, focusing
  * [ ] special modes
    * editing markdown
    * working with git
      * http://blog.atom.io/2014/03/13/git-integration.html
  * [ ] basic customization
    * on load script
    * customizing
      * look/feel - css, styleguide
      * keybindings
      * default file grammar
      * language specific settings
    * snippets
  * [ ] common packages to use
    * gist?
    * autocomplete
    * github
    * stack trace
    * live archive
  * [ ] atom from the command line
* Writing packages
  * Developer tools
    - reload, live reload
    - keybinding resolver
    - timecop
    - devmode
  * Creating a package
    * Getting started
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
        * Atom.io package system (adding, searching, stars)
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
      * decoration (http://blog.atom.io/2014/07/24/decorations.html)
    * Best practices (patterns and anti-patterns)
      * aggregating subscriptions
      * view best practices
      * don't make a slow package
      * CI for packages (http://blog.atom.io/2014/04/25/ci-for-your-packages.html)
  * Creating themes
  * Creating grammars
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
    * Commit conventions
* Atom Shell
* Reference Manual


## Other Stuff - Notes - Todo?

* best practices
  * don't add duplicate keys to your cson/json files

* Coming from
  * TextMate
  * Sublime
  * Emacs
  * Vim
