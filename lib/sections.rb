def lookup_section(datafile, title)
  toc = TableOfContents.new
  toc.index_of(title)
end
