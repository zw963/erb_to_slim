require 'spec_helper'
require 'erb_to_slim/pattern'

describe ErbToSlim::Pattern do
  include ErbToSlim::Pattern

  specify do
    html_tags_list.must_equal 'a|abbr|acronym|address|area|b|base|bdo|big|blockquote|body|br|button|caption|cite|code|col|colgroup|dd|del|dfn|div|dl|DOCTYPE|dt|em|fieldset|form|h1|h2|h3|h4|h5|h6|head|html|hr|i|img|input|ins|kbd|label|legend|li|link|map|meta|noscript|object|ol|optgroup|option|p|param|pre|q|samp|script|select|small|span|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|ul|var'
  end

  specify do
    js_tag.match(<<-'HERE')
<script>
  $(document).ready(function(){
    });
</script>
HERE
    $&.must_equal '<script>
  $(document).ready(function(){
    });
</script>'
  end

  specify do
    erb_exec_tag.match('<%any char%>').wont_be_nil
    erb_exec_tag.match('<% any char%>').wont_be_nil
    erb_exec_tag.match('<%any char %>').wont_be_nil
    erb_exec_tag.match('<% any char %>').wont_be_nil
    erb_exec_tag.match('<% any char %>').wont_be_nil
    erb_exec_tag.match('<% any char -%>').wont_be_nil
    erb_exec_tag.match('<%- any char -%>').wont_be_nil
    $1.must_equal 'any char'
    erb_exec_tag.match('<%
for i in 1..10
  p i
end
 %>').wont_be_nil
    $1.must_equal 'for i in 1..10
  p i
end'
    close_tag.match('<% end %>').wont_be_nil
    close_tag.match('<%end %>').wont_be_nil
    close_tag.match('<% end%>').wont_be_nil
  end

  specify do
    html_tag.match('  <p id="id" class="class1 class2" >   Hello  ')
    $&.must_equal '  <p id="id" class="class1 class2" >   Hello  '
    $1.must_equal '  '
    $2.must_equal 'p'
    $3.must_equal ' id="id" class="class1 class2"'
    $4.must_equal 'Hello  '

    html_tag.match('  <input type="type" name="name" value="value" />')
    $&.must_equal '  <input type="type" name="name" value="value" />'
    $1.must_equal '  '
    $2.must_equal 'input'
    $3.must_equal ' type="type" name="name" value="value"'
    $4.must_equal ''
  end

  specify do
    'for i in 1..100 do
  print i
end
%>'.match(/#{multiline_string_which_not_match('<%=')}%>/)
    $&.must_equal 'for i in 1..100 do
  print i
end
%>'
    'test <%= for i in 1..100 do
  print i
end
%>'.match(/^#{multiline_string_which_not_match('<%=')}}%>$/)
    $&.must_be_nil
  end

  specify do
    erb_eval_tag.match('<%= Time.now %>').wont_be_nil
    erb_eval_tag.match('<%=Time.now%>').wont_be_nil
    erb_eval_tag.match('<%=Time.now %>').wont_be_nil
    erb_eval_tag.match('<%= Time.now%>').wont_be_nil
    erb_eval_tag.match('  <%= Time.now -%>').wont_be_nil
    $1.must_equal '  '
    $2.must_equal nil
    $3.must_equal 'Time.now'

    erb_eval_tag.match('  p <%= Time.now -%>')
    $1.must_equal '  '
    $2.must_equal 'p'
    $3.must_equal 'Time.now'

    erb_eval_tag.match('<%= 1+
1%>').wont_be_nil
    $1.must_equal ""
    $2.must_equal nil
    $3.must_equal '1+
1'
  end

  specify do
    string_literal.match('  p Hello')
    $1.must_equal '  '
    $2.must_equal 'p'
    $3.must_equal 'Hello'

    string_literal.match(' abc Hello')
    $1.must_equal ' '
    $2.must_be_nil
    $3.must_equal 'abc Hello'

    string_literal.match(' | Hello world')
    $2.must_be_nil

    string_literal.match(' - puts "hello world"')
    $2.must_be_nil

    string_literal.match(' = 1 + 1')
    $2.must_be_nil

    string_literal.match(' #{1+1}')
    $2.must_be_nil

    string_literal.match(' @ jsCode();')
    $2.must_be_nil
  end

  specify do
    'div id="id" class="class" '.must_match tag_with_id
    'div class="class" id="id" '.must_match tag_with_id
    "div class='class' id='id' ".must_match tag_with_id
    'div class="class" '.must_match tag_with_class
    'div class="class" '.must_match tag_with_class
    'div class="class" '.wont_match tag_with_id
  end
end
