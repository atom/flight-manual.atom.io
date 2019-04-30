require 'github/markdown'
require 'json'

class ApiJsonFilter < Nanoc::Filter
  identifier :api_json

  def octicon(name)
    "<span class=\"octicon octicon-#{name}\"></span>"
  end

  def markdown(text)
    GitHub::Markdown.render(text)
  end

  def class_source_link(data, params)
    <<~HTML
      <a
        class="document-source"
        href="#{data["srcUrl"]}"
        title="View class source">
        #{octicon("file-code")}
      </a>
    HTML
  end

  def description(data, params)
    markdown(data["description"])
  end

  def page_title(data, params = {})
    <<~HTML
      <h2 class="page-title">
        #{data["name"]}
        #{visibility_label(data, params)}
        #{class_source_link(data, params)}
      </h2>
    HTML
  end

  def sections(data, params = {})
    section_text = data["sections"].map do |section|
      <<~HTML
        <h2 class="detail-section">#{section["name"]}</h2>
      HTML
    end

    section_text.join("\n")
  end

  def visibility_label(data, params)
    <<~HTML
      <span
        class="label label-#{data["visibility"].downcase}"
        title="This class is in the #{data["visibility"].downcase} API">
        #{data["visibility"]}
      </span>
    HTML
  end

  def run(content, params = {})
    data = JSON.parse(content)

    page_title(data, params) +
      description(data, params) +
      sections(data, params)
  end
end
