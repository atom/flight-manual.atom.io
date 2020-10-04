---
title: Upgrading Your UI Theme Or Package Selectors
---

{{#Atom}}

**Note:** The Shadow DOM was removed in Atom `1.13`. The `::shadow` and `/deep/` selectors and the context-targeted style sheets described below won't work and should not be used anymore.

{{/Atom}}


### Upgrading Your UI Theme Or Package Selectors

In addition to changes in Atom's scripting API, we'll also be making some breaking changes to Atom's DOM structure, requiring style sheets and keymaps in both packages and themes to be updated.

#### Deprecation Cop

Deprecation Cop will list usages of deprecated selector patterns to guide you. You can access it via the Command Palette (`cmd-shift-p`, then search for `Deprecation`). It breaks the deprecations down by package:

![Deprecation Cop](../../images/dep-cop.png)

#### Custom Tags

Rather than adding classes to standard HTML elements to indicate their role, Atom now uses custom element names. For example, `<div class="workspace">` has now been replaced with `<atom-workspace>`. Selectors should be updated accordingly. Note that tag names have lower specificity than classes in CSS, so you'll need to take care in converting things.

| Old Selector | New Selector |
| :------------- | :------------- |
| `.editor`           | `atom-text-editor` |
| `.editor.mini`      | `atom-text-editor[mini]` |
| `.workspace`        | `atom-workspace` |
| `.horizontal`       | `atom-workspace-axis.horizontal` |
| `.vertical`         | `atom-workspace-axis.vertical` |
| `.pane-container`   | `atom-pane-container` |
| `.pane`             | `atom-pane` |
| `.tool-panel`       | `atom-panel` |
| `.panel-top`        | `atom-panel.top` |
| `.panel-bottom`     | `atom-panel.bottom` |
| `.panel-left`       | `atom-panel.left` |
| `.panel-right`      | `atom-panel.right` |
| `.overlay`          | `atom-panel.modal` |

#### Supporting the Atom DOM

Text editor content is now rendered in the atom DOM, which shields it from being styled by global style sheets to protect against accidental style pollution. For more background on the atom DOM, check out the [Atom DOM 101](https://www.html5rocks.com/en/tutorials/webcomponents/atomdom) on HTML 5 Rocks. If you need to style text editor content in a UI theme, you'll need to circumvent this protection for any rules that target the text editor's content. Some examples of the kinds of UI theme styles needing to be updated:

* Highlight decorations
* Gutter decorations
* Line decorations
* Scrollbar styling
* Anything targeting a child selector of `.editor`

During a transition phase, it will be possible to enable or disable the text editor's atom DOM in the settings, so themes will need to be compatible with both approaches.

##### Atom DOM Selectors

Chromium provides two tools for bypassing atom boundaries, the `::atom` pseudo-element and the `/deep/` combinator. For an in-depth explanation of styling the atom DOM, see the [Atom DOM 201](https://www.html5rocks.com/en/tutorials/webcomponents/atomdom-201#toc-style-cat-hat) article on HTML 5 Rocks.

###### `::Atom`

The `::atom` pseudo-element allows you to bypass a single atom root. For example, say you want to update a highlight decoration for a linter package. Initially, the style looks as follows:

```css
// Without atom DOM support
atom-text-editor .highlight.my-linter {
  background: hotpink;
}
```

In order for this style to apply with the atom DOM enabled, you will need to add a second selector with the `::atom` pseudo-element. You should leave the original selector in place so your theme continues to work with the atom DOM disabled during the transition period.

```css
// With atom DOM support
atom-text-editor .highlight.my-linter,
atom-text-editor::atom .highlight.my-linter {
  background: blue;
}
```

Check out the [find-and-replace](https://github.com/atom/find-and-replace/blob/95351f261bc384960a69b66bf12eae8002da63f9/stylesheets/find-and-replace.less#L9-L29) package for another example of using `::atom` to pierce the atom DOM.

###### `/deep/`

The `/deep/` combinator overrides *all* atom boundaries, making it useful for rules you want to apply globally such as scrollbar styling. Here's a snippet containing scrollbar styling for the Atom Dark UI theme before atom DOM support:

```css
// Without atom DOM support
.scrollbars-visible-always {
  ::-webkit-scrollbar {
    width: 8px;
    height: 8px;
  }

  ::-webkit-scrollbar-track,
  ::-webkit-scrollbar-corner {
    background: @scrollbar-background-blue;
  }

  ::-webkit-scrollbar-thumb {
    background: @scrollbar-blue;
    border-radius: 5px;
    box-atom: 0 0 1px black inset;
  }
}
```

To style scrollbars even inside of the shadow DOM, each rule needs to be prefixed with `/deep/`. We use `/deep/` instead of `::atom` because we don't care about the selector of the host element in this case. We just want our styling to apply everywhere.

```css
// With atom DOM support using /deep/
.scrollbars-visible-always {
  /deep/ ::-webkit-scrollbar {
    width: 8px;
    height: 8px;
  }

  /deep/ ::-webkit-scrollbar-track,
  /deep/ ::-webkit-scrollbar-corner {
    background: @scrollbar-background-blue;
  }

  /deep/ ::-webkit-scrollbar-thumb {
    background: @scrollbar-blue;
    border-radius: 5px;
    box-atom: 0 0 1px black inset;
  }
}
```

##### Context-Targeted Style Sheets

The selector features discussed above allow you to target atom DOM content with specific selectors, but Atom also allows you to target a specific atom DOM context with an entire style sheet. The context into which a style sheet is loaded is based on the file name. If you want to load a style sheet into the editor, name it with the `.atom-text-editor.less` or `.atom-text-editor.css` extensions.

```
my-ui-theme/
  styles/
    index.less                   # loaded globally
    index.atom-text-editor.less  # loaded in the text editor shadow DOM
```

Check out this [style sheet](https://github.com/atom/decoration-example/blob/master/styles/decoration-example.atom-text-editor.less) from the decoration-example package for an example of context-targeting.

Inside a context-targeted style sheet, there's no need to use the `::shadow` or `/deep/` expressions. If you want to refer to the element containing the shadow root, you can use the `::host` pseudo-element.

During the transition phase, style sheets targeting the `atom-text-editor` context will *also* be loaded globally. Make sure you update your selectors in a way that maintains compatibility with the shadow DOM being disabled. That means if you use a `::host` pseudo element, you should also include the same style rule matches against `atom-text-editor`.
