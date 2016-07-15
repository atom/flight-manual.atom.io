require 'nanoc-conref-fs'

class TableOfContents
  attr_reader :appendices, :chapters

  def initialize
    toc = NanocConrefFS::Variables.fetch_data_file('toc', :default)
    @chapters = load_chapters(toc.values.first)
    @appendices = load_chapters(toc.values.last)
  end

  def index_of(title)
    @chapters.each_with_index do |chapter, chapter_index|
      chapter.section_names.each_with_index do |section, section_index|
        return "#{chapter_index + 1}.#{section_index + 1}" if title == section
      end
    end

    @appendices.each_with_index do |chapter, chapter_index|
      chapter.section_names.each_with_index do |section, section_index|
        return "#{('A'.ord + chapter_index).chr}.#{section_index + 1}" if title == section
      end
    end

    nil
  end

  private

  def load_chapters(chapters)
    chapters.map { |name, sections| Chapter.new(name, sections) }
  end
end
