# Chapter 3

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
    * converting-a-text-mate-theme.md
    * theme-variables.md
    * Shadow DOM
      - https://atom.io/docs/latest/upgrading/upgrading-your-ui-theme
  * Creating grammars
    * converting-a-text-mate-bundle.md

# Chapter 4

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
