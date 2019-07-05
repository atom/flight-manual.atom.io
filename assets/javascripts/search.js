$(document).ready(function() {
  const params = new URLSearchParams(window.location.search);
  const versionsDropdown = $("#documents-search-versions");

  if (params.has("v")) {
    versionsDropdown
      .children(`option[value="${params.get("v")}"]`)
      .prop("selected", true);
  }
  const version = versionsDropdown.children(":selected").val();
  const search = new LunrSearch($("#quicksearch-query"), {
    query: params.get("q"),
    version,
    indexUrl: "/search/v" + version + ".json",

    quickSearchResults: ".autocomplete-results",
    quickSearchEntries: ".result-group",
    quickSearchTemplate: "#quicksearch-results-template",

    searchResults: ".search-container",
    searchEntries: ".search-results",
    searchTemplate: "#search-results-template"
  });

  versionsDropdown.change(function() {
    const version = versionsDropdown.children(":selected").val();
    if (isSearchPage()) {
      params.set("v", version);
      window.history.pushState(null, null, "?" + params.toString());
    } else if (isApiDocsPage()) {
      const components = window.location.pathname.split('/')
      if (!components[components.length - 1]) {
        // Pop trailing slash off
        components.pop()
      }
      const page = components.pop()
      window.location.replace(`/api/v${version}/${page}`)
    }

    search.reindex(version, "/search/v" + version + ".json");
  });
});

function debounce(fn) {
  let timeout;
  return function() {
    const args = Array.prototype.slice.call(arguments);
    const context = this;
    clearTimeout(timeout);
    timeout = setTimeout(function() {
      fn.apply(context, args);
    }, 100);
  };
}

class LunrSearch {
  constructor(elem, options) {
    this.search_elem = elem;
    if (options.query) {
      this.search_elem.val(options.query);
    }
    this.quickSearchResults = $(options.quickSearchResults);
    this.quickSearchEntries = $(
      options.quickSearchEntries,
      this.quickSearchResults
    );
    this.searchResults = $(options.searchResults);
    this.searchEntries = $(options.searchEntries, this.searchResults);
    this.quickSearchTemplate = this.compileTemplate(
      $(options.quickSearchTemplate)
    );
    this.searchTemplate = this.compileTemplate($(options.searchTemplate));
    this.searchMoreButton = $(".search-more-button");
    this.searchSpinner = $(".search-spinner");
    this.searchHeader = $(".search-header");
    this.searchWorker = new Worker("/assets/javascripts/search_worker.js");

    this.reindex(options.version, options.indexUrl);

    this.bindQuicksearchKeypress();
    this.bindQuicksearchBlur();
    this.bindQuicksearchFocus();

    this.searchWorker.addEventListener("message", event => {
      if (event.data.type.indexed) {
        this.populateSearchFromQuery();
      } else {
        if (event.data.type.quicksearch) {
          this.displayQuicksearch(event.data.query, event.data.results);
        } else {
          this.displaySearchResults(event.data.query, event.data.results);
        }
      }
    });
    this.searchMoreButton.on("click", () => {
      if (this.page) {
        this.page = this.page + 1;
      } else {
        this.page = 2;
      }
    });
  }

  compileTemplate($template) {
    const template = $template.text();
    Mustache.parse(template, "[[ ]]");
    return function(view, partials) {
      return Mustache.render(template, view, partials);
    };
  }

  reindex(version, indexDataUrl) {
    this.version = version;
    $.getJSON(indexDataUrl, data => {
      data.type = { index: true };
      this.searchWorker.postMessage(data);
    });
  }

  bindQuicksearchKeypress() {
    this.search_elem.bind(
      "keyup",
      debounce(() => {
        this.search(this.search_elem.val());
      })
    );
  }

  bindQuicksearchFocus() {
    this.search_elem.bind(
      "focus",
      debounce(() => {
        if (this.search_elem.val()) {
          this.quickSearchResults.show();
        }
      })
    );
  }

  bindQuicksearchBlur() {
    this.search_elem.bind(
      "blur",
      debounce(() => {
        this.quickSearchResults.hide();
      })
    );
  }

  bindQuicksearchMousedown() {
    $(".autocomplete-results a").each(function(_, el) {
      $(el).bind("mousedown", function(event) {
        event.preventDefault();
        return;
      });
    });
  }

  search(query) {
    this.query = query;
    this.searchWorker.postMessage({
      query: query,
      quicksearch: !isSearchPage(),
      isSearchPage: isSearchPage(),
      type: {
        search: true
      }
    });
  }

  displayQuicksearch(query, entries) {
    this.quickSearchEntries.empty();
    if (entries.length > 0) {
      entries = entries.slice(0, 10);
      this.quickSearchEntries.append(
        this.quickSearchTemplate({ entries: entries })
      );
      this.quickSearchResults.show();
      const _href = $(".quicksearch-seemore").attr("href");
      $(".quicksearch-seemore").attr(
        "href",
        `${_href}${query}&v=${this.version}`
      );
      this.bindQuicksearchMousedown();
    }
  }

  displaySearchResults(query, entries) {
    this.searchEntries.empty();
    $(".search-query").text(query);
    if (entries.length === 0) {
      this.searchSpinner.addClass("hidden");
      this.searchHeader.find(".message").text("No results for");
      this.searchHeader.find(".results").text(query);
    } else {
      this.entries = entries;
      this.searchSpinner.addClass("hidden");
      this.searchMoreButton.removeClass("hidden");
      this.searchHeader.find(".message").text("Search results for");
      this.searchHeader.find(".results").text(query);
      this.populateEntries();
    }
  }

  populateEntries() {
    const max = 50 * (this.page || 1);
    const entriesToShow = this.entries.slice(max - 50, max - 1);
    if (this.entries.length < max) {
      this.searchMoreButton.addClass("hidden");
    }
    this.searchEntries.append(this.searchTemplate({ entries: entriesToShow }));
  }

  populateSearchFromQuery() {
    const query = this.search_elem.val();
    if (query) {
      this.search_elem.val(query);
      this.search(query);
    } else {
      this.search(" ");
    }
  }
}

function isSearchPage() {
  return window.location.pathname.match(/\/search(?:\/|$)/);
}

function isApiDocsPage() {
  return window.location.pathname.startsWith('/api/')
}
