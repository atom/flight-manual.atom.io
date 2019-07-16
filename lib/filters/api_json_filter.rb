require 'json'
require 'kramdown'

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
    Kramdown::Document.new(text, {input: 'GFM'}).to_html
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
    id = "#{scope}-#{func["name"]}"
    prefix = case scope
             when 'instance' then '::'
             when 'class' then '.'
             else ''
             end

    <<~HTML
      <div
        class="api-entry js-api-entry #{visibility_class(func["visibility"])}"
        id="#{id}">
        <h3 class="name">
          <a href="##{id}" class="js-api-name method-signature" name="#{id}">
            #{prefix}#{func["name"]}#{argument_list(func)}
          </a>
          #{source_link(func)}
        </h3>
        <div class="method-summary-wrapper">
          #{summary(func)}
          #{description(func)}
          #{arguments_table(func) if func["arguments"]}
          #{return_values_table(func) if func["returnValues"]}
        </div>
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
          #{arg["isOptional"] ? '<span class="optional">optional</span>' : ''}
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
    id = "#{scope}-#{prop["name"]}"
    <<~HTML
      <div
        class="api-entry js-api-entry #{visibility_class(prop["visibility"])}"
        id="#{scope}-#{prop["name"]}">
        <h3 class="name">
          <a href="##{id}" class="js-api-name" name="#{id}">
            <span class="operator operator-instance">::</span>#{prop["name"].strip}
          </a>
          #{property_source_link(prop)}
        </h3>
        <div class="method-summary-wrapper">
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
        #{visibility(data["visibility"])}
      </span>
    HTML
  end

  # ----- Page Sections -----

  def class_description(data)
    <<~HTML
      <div class="markdown-body">
        #{markdown(data["description"])}
      </div>
    HTML
  end

  def class_examples(data)
    examples = Array(data["examples"])
    return '' if examples.empty?

    entries = examples.map do |example|
      description = ''
      unless example['description'].empty?
        description = <<~HTML
          <div class="description markdown-body">
            #{markdown(example['description'])}
          </div>
        HTML
      end

      <<~HTML
        <div class="example">
          #{description}
          #{markdown(example['raw'])}
        </div>
      HTML
    end.join("\n")

    <<~HTML
      <h2 class="section">Examples</h2>
      <div class="document-examples markdown-body">
        #{entries}
      </div>
    HTML
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

  def uncategorized_methods(data)
    uncategorized_class_methods = data["classMethods"].select { |func| func["sectionName"].nil? }
    uncategorized_instance_methods = data["instanceMethods"].select { |func| func["sectionName"].nil? }

    return '' if (uncategorized_class_methods + uncategorized_instance_methods).empty?

    <<~HTML
      <h2 class="detail-section">Methods</h2>
      #{uncategorized_class_methods.map { |func| method(func, "class") }.join}
      #{uncategorized_instance_methods.map { |func| method(func, "instance") }.join}
    HTML
  end

  def instance_methods(methods)
    extended, essential = methods.partition { |func| func["visibility"] == "Extended" }

    html = ""
    html << essential.map { |func| method(func, "instance") }.join
    if extended.any?
      if essential.empty?
        html << '<p class="no-methods-message">This section only has Extended methods.</p>'
      end
      html << "<h4>Extended Methods</h4>"
      html << extended.map { |func| method(func, "instance") }.join
    end

    html
  end

  def sections(data)
    section_names = data["sections"].map { |section| section["name"] }.uniq
    section_text = section_names.map do |section_name|
      _class_methods = data["classMethods"].select { |func| func["sectionName"] == section_name }
      _instance_properties = data["instanceProperties"].select { |prop| prop["sectionName"] == section_name }
      _instance_methods = data["instanceMethods"].select { |func| func["sectionName"] == section_name }

      <<~HTML
        <h2 class="detail-section">#{section_name}</h2>
        #{_class_methods.map { |func| method(func, "class") }.join}
        #{_instance_properties.map { |prop| property(prop, "instance") }.join}
        #{instance_methods(_instance_methods)}
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
      class_examples(data) +
      uncategorized_methods(data) +
      sections(data)
  end
end
