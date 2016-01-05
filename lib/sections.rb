def lookup_section(datafile, title)
  chapter_itr = 1
  toc = NanocConrefFS::Variables.fetch_data_file(datafile, :default)

  toc.values.each do |children|
    section_itr = 1
    children.each do |child|
      return "#{chapter_itr}.#{section_itr}" if child == title
      section_itr += 1
    end
    chapter_itr += 1
  end
end
