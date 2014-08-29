# -*- coding: utf-8 -*-

require_relative 'pattern'

module ErbToSlim
  module Engine
    include Pattern

    def markup_js_tag
      gsub!(js_tag) { $&.gsub(/\n[\s\t]*/, '\&@ ') }
      self
    end

    def cleanup_close_tag
      gsub!(close_tag, '')
      self
    end

    def replace_html_tag
      gsub!(html_tag) { $4.empty? ? "#$1#$2#$3" : "#$1#$2#$3 #$4" }
      self
    end

    def replace_erb_exec_tag
      gsub!(erb_exec_tag) { "- #$1".gsub(/\n[\s\t]*/, '\&- ') }
      self
    end

    def replace_erb_eval_tag
      gsub!(erb_eval_tag) do
        $2.nil? ? "#$1= #{$3.gsub(/\n[\s\t]*/, '\&= ')}" : "#$1#$2 = #{$3.gsub(/\n[\s\t]*/, '\&= ')}"
      end
      self
    end

    def replace_string_literal
      gsub!(string_literal) { $2.nil? ? "#$1| #$2#$3" : $& }
      self
    end

    def replace_tag_with_id
      gsub!(tag_with_id) { $1 == 'div' ? "\##$4#$2#$5" : "#$1\##$4#$2#$5" }
      self
    end

    def replace_tag_with_class
      gsub!(tag_with_class) { $1 == 'div' ? ".#{$4.tr(' ', '.')}#$2#$5" : "#$1.#{$4.tr(' ', '.')}#$2#$5" }
      self
    end

    def finally_clean_up
      gsub!('@ ', '')
      gsub!(/<%= *(.*?) *-?%>/, '#{\1}')
      self
    end
  end
end
