(function() {
  $(document).on("click", ".js-api-name", function(e) {
    e.preventDefault();
    toggleApiEntry($(this).attr("href"));
    return false;
  });

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
})();
