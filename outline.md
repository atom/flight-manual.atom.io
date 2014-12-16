# Book Outline

* Introduction
  * [x] Why Atom
  * [x] Installing
  * [x] Atom Basics
    * [x] Command Palette
    * [x] Settings and preferences
      * Changing the default color scheme
      * Toggle soft wrap by default
    * [x] Opening, modifying and saving files
      * Fuzzy-finder, modified file
      * buffers
    * [x] Opening a project
* Using Atom
  * [x] packages
    * finding and installing
    * settings, enabling
    * upgrading
  * [x] themes
    * finding and installing
    * switching
  * [ ] find and replace
  * [ ] selections
  * [ ] movement
    * tags/symbols
  * [ ] working with text
    * multiple cursors
      - cmd-shift-L (selection to cursors)
      - cntl-shift-up (add cursor up/down)
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
    * pain split package
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
      * config settings
        * language specific settings
    * autocomplete
    * snippets
      * emmet, autocomplete+
  * [ ] common packages to use
    * gist?
    * autocomplete
    * github
    * stack trace
    * live archive
  * [ ] atom from the command line

# Possible Other

* Hacking Atom
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
      * views / models
      * TODO - organize
        * settings (how to enable the settings button on the package installer)
        * notifications package
        * config api
          - http://blog.atom.io/2014/10/02/config-api-has-schema.html
          - http://blog.atom.io/2014/10/31/language-scoped-config.html
          - https://atom.io/docs/latest/advanced/scopes-and-scope-descriptors
        * subscriptions
          - http://blog.atom.io/2014/09/16/new-event-subscription-api.html
        * creating dom elements
          - no longer spacepen
        * runners
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
    * Maintaining Packages
      * changelog
      * issue tracker
    * Best practices (patterns and anti-patterns)
      * aggregating subscriptions
      * view best practices
      * don't make a slow package
      * CI for packages (http://blog.atom.io/2014/04/25/ci-for-your-packages.html)
  * Creating themes
    * Shadow DOM
      - https://atom.io/docs/latest/upgrading/upgrading-your-ui-theme
  * Creating grammars
* Contributing to Atom
  * To packages
    * Cloning and apm linking
    * apm install/update
    * Native modules
    * Running specs
    * Link to sending a pull request
  * To core
    * Opening issues
    * Roadmaps
      - http://blog.atom.io/2014/10/23/public-roadmap.html
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
  * developing a new project in atom shell
* Reference Manual
