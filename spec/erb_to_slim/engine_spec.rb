require 'minitest/autorun'
require 'minitest/pride'

require_relative '../../lib/erb_to_slim/engine'

describe ErbToSlim::Engine do
  String.send :include, ErbToSlim::Engine

  it "mark up js tag content" do
    <<-'HERE'.markup_js_tag.must_equal <<-'HERE1'
<script type="text/javascript">
    $(document).ready(function(){
    });
</script>
<html>
  <body>
  </body>
</html>
<script type="text/javascript">
    $(document).ready(function(){
    });
</script>
HERE
<script type="text/javascript">
    @ $(document).ready(function(){
    @ });
@ </script>
<html>
  <body>
  </body>
</html>
<script type="text/javascript">
    @ $(document).ready(function(){
    @ });
@ </script>
HERE1
  end

  it "clean up <% end %> and close_tag" do
    <<-'HERE1'.cleanup_close_tag.must_equal <<-'HERE2'
<% content_for :xxx do %>
  <%= Time.now %>
<% end %>
<p> Hello </p>
<div>
  Hello
</div>
HERE1
<% content_for :xxx do %>
  <%= Time.now %>
<p> Hello
<div>
  Hello
HERE2
  end

# '\k<space>\k<tag>\k<attrs>\k<value>'

# <input type="hidden" name="name" value="value"/>
# <img href="href"/>
# <p> Hello

  it "replace html tag" do
  <<-'HERE1'.replace_html_tag.must_equal <<-'HERE2'
<p> Hello
<input type="hidden" name="name" value="value"/>
HERE1
p Hello
input type="hidden" name="name" value="value"
HERE2
end

it "replace erb execute tag" do
<<-'HERE1'.replace_erb_exec_tag.must_equal <<-HERE2
  <% for i in 1..10 %>
    <%= print i %>

<% puts "hello
world!" %>
HERE1
  - for i in 1..10
    <%= print i %>

- puts "hello
- world!"
HERE2
end

  it "replace erb eval tag" do
    '  <%= Time.now %>'.replace_erb_eval_tag.must_equal '  = Time.now'
    '  <%= Time.
    now %>'.replace_erb_eval_tag.must_equal '  = Time.
    = now'
    '  p <%= Time.now %>'.replace_erb_eval_tag.must_equal '  p = Time.now'
    '  abc <%= Time.now %>'.replace_erb_eval_tag.must_equal '  abc <%= Time.now %>'
    '  p Current time is: <%= Time.now %>'.replace_erb_eval_tag.must_equal '  p Current time is: <%= Time.now %>'
    '  p <%= Time.now %> is reached'.replace_erb_eval_tag.must_equal '  p <%= Time.now %> is reached'
  end

  it "replace string literal" do
    '   Hello world!'.replace_string_literal.must_equal '   | Hello world!'
    '   Hello'.replace_string_literal.must_equal '   | Hello'
    '   p Hello world!'.replace_string_literal.must_equal '   p Hello world!'
    '   | Hello world!'.replace_string_literal.must_equal '   | Hello world!'
    '   - puts "hello"'.replace_string_literal.must_equal '   - puts "hello"'
    '   = 1+1'.replace_string_literal.must_equal '   = 1+1'
    '   #{1+1}'.replace_string_literal.must_equal '   #{1+1}'
    '   @ jsCode();'.replace_string_literal.must_equal '   @ jsCode();'
  end

  it "replace tag_with_id" do
    'p id="id_1"'.replace_tag_with_id.must_equal 'p#id_1'
    'p class="class1 class2" id="id_1"'.replace_tag_with_id .must_equal 'p#id_1 class="class1 class2"'

    'p id="id_1" class="@{class_name}" style="style"'.replace_tag_with_id
      .must_equal 'p#id_1 class="@{class_name}" style="style"'

    'div id="id_1" class="@{class_name}"'.replace_tag_with_id.must_equal '#id_1 class="@{class_name}"'
  end

  it "replace tag_with_class" do
    'p class="class-1" style="style"'.replace_tag_with_class.must_equal 'p.class-1 style="style"'
    'p class="class-1 class-2"'.replace_tag_with_class.must_equal 'p.class-1.class-2'
    'div class="class-1 class-2"'.replace_tag_with_class.must_equal '.class-1.class-2'
    'p#id style="style" class="class-1 class-2"'.replace_tag_with_class.must_equal 'p#id.class-1.class-2 style="style"'
  end
end
