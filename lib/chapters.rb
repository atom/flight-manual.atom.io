def lookup_chapter(datafile, title)
  toc = TableOfContents.new
  toc.chapter_index(title)
end
