require 'active_support/core_ext/string'

module GitHubHelp
  module Strings
    def safe_embed(str)
      result = str.dup
      result.gsub('\\', '\\\\\\').gsub('"', '\"')
    end

    def strip_html(input)
      input.gsub(/<.*?>/m, '')
    end

    def compress(string)
      strip_html(string.squish!)
    end

    def pipeline_render(str)
      return '' if str.blank?
      NanocHtmlPipeline::Filter.new.run(str, @config[:pipeline_config])
    end

    def inject_enterprise_version(identifier)
      identifier.to_s.sub(/admin/, "#{@config[:latest_enterprise_version]}/admin")
    end
  end
end

include GitHubHelp::Strings
