require 'nanoc-conref-fs'
require 'nanoc-html-pipeline'
require 'html/pipeline/asciidoc_filter'
require 'html/pipeline/rouge_filter'
require 'active_support/core_ext/string'

require_relative 'sections'
require_relative 'strings'

begin
  require 'awesome_print'
rescue LoadError; end

include Nanoc::Helpers::Rendering
Nanoc::Helpers::Rendering.module_eval do
  if respond_to? :render
    alias_method :renderp, :render
    remove_method :render
  end
end
