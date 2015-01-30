# Chapter 3

your-first-package.md
creating-a-package.md
debugging.md
publishing-a-package.md

writing-specs.md

contributing-to-packages.md

creating-a-theme.md
theme-variables.md
converting-a-text-mate-bundle.md
converting-a-text-mate-theme.md

* Hacking Atom
  * Cookbook
    * Word Count Package (Basic)
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
      * developer tools
        - reload, live reload
        - devmode
        - https://atom.io/docs/v0.174.0/debugging
    * Word Count Status Bar (status bar manipulation)
    * Go To Line Package (simple with feedback and cursor movement)
    * Open On GitHub - (no UI, just run command)
    * Snippets - (modify text in a buffer)
    * Linter - (modify text in a buffer, shell to external command)
    * Preview Pane (add a panel)
    * Fuzzy Finder (modal and open file in new tab)
    * Tree View / Mini-map (add a sidebar panel)
    * Status Bar (add small panel)
    * Git-Log / Settings View (standalone UI in tab)
    * Git-status / Bookmarks (decorate gutter)
    * Autocomplete / Color picker (in-context UI)
    * Vim-mode (editor remapping)
    * Image View (file type rendering handler)
    * Language (GFM?)
      * Creating grammars
      * converting-a-text-mate-bundle.md
    * Unity UI (UI theme)
      * converting-a-text-mate-theme.md
      * theme-variables.md
      * Shadow DOM
      - https://atom.io/docs/latest/upgrading/upgrading-your-ui-theme
  * advanced dev tools
    - keybinding resolver
    - timecop
  * Maintaining Packages
    * how to publish
      * Atom.io package system (adding, searching, stars)
    * changelog
    * issue tracker
  * Best practices (patterns and anti-patterns)
    * aggregating subscriptions
    * view best practices
    * don't make a slow package
    * CI for packages (http://blog.atom.io/2014/04/25/ci-for-your-packages.html)

* Make sure we include
  * scopes (https://atom.io/docs/v0.174.0/advanced/scopes-and-scope-descriptors)
  * views / models
  * settings (how to enable the settings button on the package installer)
  * notifications package
  * config api
    - http://blog.atom.io/2014/10/02/config-api-has-schema.html
    - http://blog.atom.io/2014/10/31/language-scoped-config.html
    - https://atom.io/docs/latest/advanced/scopes-and-scope-descriptors
  * subscriptions
    - http://blog.atom.io/2014/09/16/new-event-subscription-api.html
    * subscribing to events
    * subscribing to commands
  * creating dom elements
    - no longer spacepen
  * runners
  * configure my package
  * add application menu/context menu
  * get all the editors
  * understand when the active editor changes
  * background tasks
  * messages to the user
  * dialogs
  * advanced keymaps (in Guides)
  * serialization
  * converting textmate bundles
  * decoration (http://blog.atom.io/2014/07/24/decorations.html)
  * modal panel
  * modal decorations
  * notifications

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

# Chapter 5

* Atom Shell
  * developing a new project in atom shell
  * https://github.com/atom/husk

# Chapter 6 / Appendix

* Reference Manual
