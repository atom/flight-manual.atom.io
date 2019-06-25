require 'github/markdown'
require 'json'

class ApiJsonFilter < Nanoc::Filter
  identifier :api_json

  def initialize(foo)
    @class_names = {}
    @class_name = nil
    @version = nil
    @mdn_base_url = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects'
  end

  # ----- Helpers -----

  def class_source_link(data)
    source_link(data, "class")
  end

  def property_source_link(data)
    source_link(data, "property")
  end

  def source_link(item, type = nil)
    <<~HTML
      <a
        class="document-source"
        href="#{item["srcUrl"]}"
        #{type ? " title=\"View #{type} source\"" : ""}>
        #{octicon("file-code")}
      </a>
    HTML
  end

  def markdown(text)
    text = link_references(text)

    GitHub::Markdown.render(text)
  end

  def link_references(text)
    braces_link_pattern = /\{(?<cname>\w+)?(::(?<fname>\w+))?\}/

    text.gsub(braces_link_pattern) do |match|
      cname = Regexp.last_match.named_captures['cname']
      fname = Regexp.last_match.named_captures['fname']

      if cname && @class_names[cname] && fname
        "[#{cname}::#{fname}](../#{cname}/#instance-#{fname})"
      elsif cname && fname
        link = File.join(@mdn_base_url, cname, fname)

        "[#{cname}::#{fname}](#{link})"
      elsif cname && @class_names[cname]
        "[#{cname}](../#{cname}/)"
      elsif cname
        link = File.join(@mdn_base_url, cname)

        "[#{cname}](#{link})"
      elsif fname
        "[::#{fname}](#instance-#{fname})"
      else
        match.to_s
      end
    end
  end

  def octicon(name)
    "<span class=\"octicon octicon-#{name}\"></span>"
  end

  def argument(arg)
    "<span class=\"argument\">#{arg["name"]}</span>"
  end

  def argument_list(func)
    args = func["arguments"]

    <<~HTML
      <span class="argument-list">(#{args ? args.map { |arg| argument(arg) }.join(", ") : ""})</span>
    HTML
  end

  def method(func, scope)
    <<~HTML
      <div
        class="api-entry js-api-entry #{visibility_class(func["visibility"])}"
        id="#{scope}-#{func["name"]}">
        <h3 class="name">
          #{func["name"]}#{argument_list(func)}
          #{source_link(func)}
        </h3>
      </div>
      <div class="api-entry method-summary-wrapper js-method-summary-wrapper">
        #{summary(func)}
        #{description(func)}
        #{arguments_table(func) if func["arguments"]}
        #{return_values_table(func) if func["returnValues"]}
      </div>
    HTML
  end

  def return_values_table(func)
    <<~HTML
      <table class="return-values">
        <thead>
          <tr>
            <th>Return values</th>
          </tr>
        </thead>
        <tbody>
          #{return_value_rows(func["returnValues"])}
        </tbody>
      </table>
    HTML
  end

  def return_value_rows(retvals)
    retvals.map do |retval|
      return_value_row(retval)
    end.join
  end

  def return_value_row(retval)
    <<~HTML
      <tr>
        <td class="markdown-body">
          #{markdown(retval["description"])}
        </td>
      </tr>
    HTML
  end

  def arguments_table(func)
    <<~HTML
      <table class="arguments">
        <thead>
          <tr>
            <th>Argument</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          #{argument_rows(func["arguments"])}
        </tbody>
      </table>
    HTML
  end

  def argument_rows(args, level = 0)
    args.map do |arg|
      argument_row(arg, level)
    end.join
  end

  def argument_row(arg, level)
    children = arg["children"]

    <<~HTML
      <tr class="markdown-body argument-depth-#{level}">
        <td>
          #{markdown("`#{arg["name"]}`")}
        </td>
        <td>
          #{markdown(arg["description"])}
        </td>
      </tr>
      #{argument_rows(children, level + 1) if children}
    HTML
  end

  def summary(obj)
    <<~HTML
      <div class="summary markdown-body">
        #{markdown(obj["summary"])}
      </div>
    HTML
  end

  def description(obj)
    text = obj["description"].tap { |s| s.slice!(obj["summary"]) }

    <<~HTML
      <div class="body markdown-body">
        <div class="description">
          #{markdown(text)}
        </div>
      </div>
    HTML
  end

  def property(prop, scope)
    <<~HTML
      <div
        class="api-entry js-api-entry #{visibility_class(prop["visibility"])}"
        id="#{scope}-#{prop["name"]}">
        <h3 class="name">
          <span class="operator operator-instance">::</span>#{prop["name"].strip}#{property_source_link(prop)}
        </h3>
        <div>
          #{summary(prop)}
        </div>
      </div>
    HTML
  end

  def visibility(viz)
    case viz
    when "Public" then "Essential"
    else viz
    end
  end

  def visibility_class(viz)
    visibility(viz).downcase
  end

  def visibility_label(data)
    <<~HTML
      <span
        class="label label-#{visibility_class(data["visibility"])}"
        title="This class is in the #{visibility_class(data["visibility"])} API">
        #{data["visibility"]}
      </span>
    HTML
  end

  # ----- Page Sections -----

  def class_description(data)
    markdown(data["description"])
  end

  def page_title(data)
    <<~HTML
      <h2 class="page-title">
        #{data["name"]}
        #{visibility_label(data)}
        #{class_source_link(data)}
      </h2>
    HTML
  end

  def sections(data)
    section_text = data["sections"].map do |section|
      props = data["instanceProperties"].select { |prop| prop["sectionName"] == section["name"] }
      methods = data["instanceMethods"].select { |func| func["sectionName"] == section["name"] }

      <<~HTML
        <h2 class="detail-section">#{section["name"]}</h2>
        #{props.map { |prop| property(prop, "instance") }.join}
        #{methods.map { |func| method(func, "instance") }.join}
      HTML
    end

    section_text.join("\n")
  end

  def run(content, params = {})
    @class_name = params[:class_name]
    @version = params[:version]

    api_dir = "#{Dir.pwd}/content/api/#{@version}"
    Dir.glob("#{api_dir}/*.json") do |entry|
      @class_names[File.basename(entry, '.json')] = true
    end

    data = JSON.parse(content)

    page_title(data) +
      class_description(data) +
      sections(data)
  end
end
