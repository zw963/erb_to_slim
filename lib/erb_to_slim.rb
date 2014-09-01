# -*- coding: utf-8 -*-

require 'erb_to_slim/pattern'
require 'erb_to_slim/engine'
require 'erb_to_slim/version'

module ErbToSlim
  def self.start!
    return p(ErbToSlim::VERSION) if ARGV.include? '--version' or ARGV.include? '-v'

    Dir.chdir Dir.pwd do
      Dir['**/*.{html.erb}'].each do |file|
        String.send(:include, ErbToSlim::Engine)

        stream = File.read(file)

        stream.markup_js_tag
        stream.cleanup_close_tag
        stream.replace_html_tag
        stream.replace_erb_exec_tag
        stream.replace_erb_eval_tag
        stream.replace_string_literal
        stream.replace_tag_with_id
        stream.replace_tag_with_class
        stream.finally_clean_up

        slim_file = "#{File.dirname(file)}/#{File.basename(file, '.erb')}.slim"

        File.open(slim_file, "w") do |f|
          f.write(stream)
        end

        puts "[1m[49m[0m[33m==>[0m #{slim_file}"

        File.rename(file, "#{file}.bak")
      end
    end
  end
end
