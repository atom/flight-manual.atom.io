require "yaml"

class ValidateArticleTitle
  attr_reader :errors

  def initialize(path)
    @errors = []
    @path = path
    @file_name = File.basename(path, ".md")
  end

  def all
    header_present?
    yaml_present?
    file_name_matches_header?
    file_name_matches_title?

    self
  end

  private

  def dasherize(text)
    return nil if text.nil?

    text.downcase
        .gsub(/[^a-zA-Z0-9]/, '-')
        .gsub(/-{2,}/, '-')
        .sub(/^-+/, '')
        .sub(/-+$/, '')
  end

  def file_name_matches_header?
    return if @header.nil?

    unless @file_name == dasherize(@header)
      @errors << format_error("File name [#{@file_name}] does not match header [#{@header}]")
    end
  end

  def file_name_matches_title?
    return if @title.nil?

    unless @file_name == dasherize(@title)
      @errors << format_error("File name [#{@file_name}] does not match title [#{@title}]")
    end
  end

  def first_header(path)
    File.readlines(path).find { |line| line =~ /^#+\s+\S+/ }
  end

  def format_error(text)
    "#{@path} - #{text}"
  end

  def header_present?
    @header_text = first_header(@path)

    if @header_text.nil?
      @errors << format_error("No header found")
    else
      @header = @header_text.sub(/^#+\s+/, '').strip
    end
  end

  def yaml_present?
    @yaml = YAML.load_file(@path)
    @title = @yaml["title"]

    if @title.nil?
      @errors << format_error("YAML header not found or 'title' attribute not present (check to ensure 'title' key is all lowercase)")
    else
      @title.strip!
    end
  end
end
