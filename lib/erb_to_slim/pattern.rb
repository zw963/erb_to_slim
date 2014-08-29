# -*- coding: utf-8 -*-

module ErbToSlim
  module Pattern
    def html_tags_array
      @html_tags_array ||= File.readlines(File.expand_path('../html_tag_list.txt', __FILE__))
        .reject {|line| line =~ /^#|^$/ }.map(&:chomp)
    end

    def html_tags_list
      @html_tags_list ||= html_tags_array.join('|')
    end

    def indentation
      /[\s\t]*+/
    end

    def multiline_string_which_not_match(str)
      str_escaped = str.gsub(/[!<>=?]/, '\\\\\&')
      /(?:.(?!#{str_escaped}))*?/m
    end

    def js_tag
      /<script *(type="text\/javascript")? *>(#{multiline_string_which_not_match('<script')})<\/script>/
    end

    def erb_exec_tag
      /<%(?!=)\s*((?m:.*?))\s*-?%>/
    end

    def close_tag
      /\s*(<% *end *-?%>|(@ )?<\/\w+>)$/
    end

    def html_tag
      /( *)<(\w+)(.*?) *(?<!%)\/?> *(.*)?/
    end

    def erb_eval_tag
      /^(#{indentation})(#{html_tags_list})? *<%=\s*(#{multiline_string_which_not_match('<%=')})\s*-?%>$/
    end

    def string_literal
      /^(#{indentation})((?:#{html_tags_list}|\||-|=|\#|@))?\b *(.*)$/
    end

    def tag_with_id
      /(\w+)(.*?) *id *= *(["'])(.*?)\3(.*?) *$/
    end

    def tag_with_class
      /([\w#]+)(.*?) *class *= *(["'])(.*?)\3(.*?) *$/
    end
  end
end
