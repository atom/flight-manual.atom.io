(function() {
  if (isApiDocsPage()) {
    $(document).on("click", ".js-api-name", function(e) {
      e.preventDefault();
      toggleApiEntry($(this).attr("href"));
      return false;
    });

    $(document).ready(function() {
      if (window.location.hash) {
        toggleApiEntry(window.location.hash);
      }

      $("#documents-search-versions").change(function() {
        const components = window.location.pathname.split("/");
        if (!components[components.length - 1]) {
          // Pop trailing slash off
          components.pop();
        }
        const page = components.pop();
        const version = this.value;
        const { hash } = window.location;
        window.location.replace(`/api/v${version}/${page}${hash}`);
      });
    });

    $(window).on("hashchange", function() {
      toggleApiEntry(window.location.hash);
    });
  }

  function toggleApiEntry(apiEntryId) {
    const entry = $(apiEntryId);
    const extendedContainer = entry.parents(".extended-methods-container");
    if (extendedContainer.length) {
      extendedContainer.addClass("show");
    }

    if (entry.hasClass("expanded")) {
      entry.removeClass("expanded");
    } else {
      entry.addClass("expanded");
      window.history.replaceState("", "", apiEntryId); // update url hash w/o adding history
    }
  }

  function isApiDocsPage() {
    return window.location.pathname.startsWith("/api/");
  }
})();
