require 'nanoc-asciidoctor'
require 'nanoc-conref-fs'

include Nanoc::Helpers::Rendering
Nanoc::Helpers::Rendering.module_eval do
  if respond_to? :render
    alias_method :renderp, :render
    remove_method :render
  end
end

require 'active_support/core_ext/string'
