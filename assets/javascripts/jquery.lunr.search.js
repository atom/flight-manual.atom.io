const searchPlugin = function () {
  const debounce = function (fn) {
    let timeout
    return function () {
      const args = Array.prototype.slice.call(arguments)
      const context = this
      clearTimeout(timeout)
      timeout = setTimeout(function () {
        fn.apply(context, args)
      }, 100)
    }
  }

  class LunrSearch {

    constructor (elem, options) {
      this.search_elem = elem
      this.quickSearchResults = $(options.quickSearchResults)
      this.quickSearchEntries = $(options.quickSearchEntries, this.quickSearchResults)
      this.searchResults = $(options.searchResults)
      this.searchEntries = $(options.searchEntries, this.searchResults)
      this.indexDataUrl = options.indexUrl
      this.quickSearchTemplate = this.compileTemplate($(options.quickSearchTemplate))
      this.searchTemplate = this.compileTemplate($(options.searchTemplate))
      this.searchMoreButton = $('.search-more-button')
      this.searchSpinner = $('.search-spinner')
      this.searchHeader = $('.search-header')
      this.searchWorker = new Worker('/assets/javascripts/search_worker.js')

      this.loadIndexData((data) => {
        data.type = {index: true}
        this.searchWorker.postMessage(data)
      })

      this.bindQuicksearchKeypress()
      this.bindQuicksearchBlur()
      this.bindQuicksearchFocus()

      this.searchWorker.addEventListener('message', (event) => {
        if (event.data.type.indexed) {
          this.populateSearchFromQuery()
        } else {
          if (event.data.type.quicksearch) {
            this.displayQuicksearch(event.data.query, event.data.results)
          } else {
            this.displaySearchResults(event.data.query, event.data.results)
          }
        }
      })
      this.searchMoreButton.on('click', (event) => {
        if (this.page) {
          this.page = this.page + 1
        } else {
          this.page = 2
        }
      })
    }

    compileTemplate ($template){
      const template = $template.text()
      Mustache.parse(template, "[[ ]]")
      return function (view, partials) {
        return Mustache.render(template, view, partials)
      }
    }

    loadIndexData (callback) {
      $.getJSON(this.indexDataUrl, callback)
    }

    bindQuicksearchKeypress () {
      let oldValue = this.search_elem.val()
      this.search_elem.bind('keyup', debounce(() => {
        const newValue = this.search_elem.val()
        this.search(newValue, newValue === oldValue ? null : true)
        oldValue = newValue
      }))
    }

    bindQuicksearchFocus () {
      this.search_elem.bind('focus', debounce(() => {
        if (this.search_elem.val()) {
          this.quickSearchResults.show()
        }
      }))
    }

    bindQuicksearchBlur () {
      this.search_elem.bind('blur', debounce(() => {
        this.quickSearchResults.hide()
      }))
    }

    bindQuicksearchMousedown () {
      $('.autocomplete-results a').each(function (idx, el) {
        $(el).bind('mousedown', function (event) {
          event.preventDefault()
          return
        })
      })
    }

    search (query, quickSearch) {
      this.searchWorker.postMessage({
        query: query,
        quicksearch: quickSearch,
        isSearchPage: this.isSearchPage(),
        type: {
          search: true
        }
      })
    }

    displayQuicksearch (query, entries) {
      this.quickSearchEntries.empty()
      if (entries.length > 0) {
        entries = entries.slice(0,10)
        this.quickSearchEntries.append(this.quickSearchTemplate({entries: entries}))
        this.quickSearchResults.show()
        const _href = $('.quicksearch-seemore').attr('href')
        $('.quicksearch-seemore').attr('href', `${_href}${query}`)
        this.bindQuicksearchMousedown()
      }
    }

    displaySearchResults (query, entries) {
      this.searchEntries.empty()
      $('.search-query').text(query)
      if (entries.length === 0) {
        this.searchSpinner.addClass('hidden')
        this.searchHeader.find('.message').text('No results for')
        this.searchHeader.find('.results').text(query)
      } else {
        this.entries = entries
        this.searchSpinner.addClass('hidden')
        this.searchMoreButton.removeClass('hidden')
        this.searchHeader.find('.message').text('Search results for')
        this.searchHeader.find('.results').text(query)
        this.populateEntries()
      }
    }

    populateEntries () {
      const max = 50 * (this.page || 1)
      const entriesToShow = this.entries.slice(max - 50, max - 1)
      if (this.entries.length < max) {
        this.searchMoreButton.addClass('hidden')
      }
      this.searchEntries.append(this.searchTemplate({entries: entriesToShow}))
    }

    populateSearchFromQuery () {
      if (!this.isSearchPage()) {
        return
      }

      const match = window.location.search.match(/[?&]q=([^&]+)/)
      if (match) {
        const q = decodeURIComponent(match[1].replace(/\+/g, ' '))
        this.search_elem.val(q)
        this.search(q, false)
      } else {
        this.search(' ', false)
      }
    }

    isSearchPage () {
      return window.location.pathname.match(/\/search(?:\/|$)/)
    }
  } // end class

  $.fn.lunrSearch = function (_options) {
    const options = $.extend({}, $.fn.lunrSearch.defaults, _options)
    new LunrSearch(this, options)
    return this
  }
}

searchPlugin(jQuery)
