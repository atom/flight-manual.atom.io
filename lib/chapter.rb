class Chapter
  attr_reader :name, :section_names

  def initialize(name, section_names)
    @name = name
    @section_names = section_names
  end
end
