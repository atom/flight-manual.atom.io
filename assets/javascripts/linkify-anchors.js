var underscore = function(text) {
  return text
    .replace(/[-\s]+/g, '_')
    .replace(/([A-Z\d]+)([A-Z][a-z])/g,'$1_$2')
    .replace(/([a-z\d])([A-Z])/g,'$1_$2')
    .toLowerCase();
};

var dasherize = function(text) {
  return underscore(text).replace(/_/g, '-');
};

var addIdsToHeaders = function(level, containingElement) {
  var headers = containingElement.getElementsByTagName("h" + level);
  for (var h = 0; h < headers.length; h++) {
    var header = headers[h];

    header.id = dasherize(header.innerHTML)
  }
};

var anchorForId = function (id) {
  var anchor = document.createElement("a");
  anchor.className = "anchor-link";
  anchor.href      = "#" + id;
  anchor.innerHTML = "<span class=\"octicon octicon-link\"></span>";
  return anchor;
};

var linkifyAnchors = function (level, containingElement) {
  var headers = containingElement.getElementsByTagName("h" + level);
  for (var h = 0; h < headers.length; h++) {
    var header = headers[h];

    if (typeof header.id !== "undefined" && header.id !== "") {
      header.appendChild(anchorForId(header.id));
    }
  }
};

window.onload = function () {
  var contentBlock = document.getElementsByClassName("document-content")[0];

  if (!contentBlock) {
    return;
  }

  for (var level = 1; level <= 6; level++) {
    addIdsToHeaders(level, contentBlock);
    linkifyAnchors(level, contentBlock);
  }
};
