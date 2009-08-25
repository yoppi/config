# .irbrc

##
# Load library
require 'rubygems'
require 'irb/completion'
require 'pp'

##
# Encoding
if RUBY_VERSION < "1.9"
  $KCODE = 'u'
end

##
# Option
#IRB.conf[:AUTO_INDENT] = true

##
# Colorize result
begin
  require 'wirble'
  wirble_opts = {
    :skip_prompt => true,
    :init_color => true
  }
  Wirble.init wirble_opts
  Wirble.colorize
rescue LoadError
  puts "Error loading Wirble. Run 'sudo gem install wirble' to enable colorzed result"
end

##
# Prompt
IRB.conf[:PROMPT][:MY_PROMPT] = {
  :PROMPT_I => "(#{RUBY_VERSION}):%03n:%i> ",
  :PROMPT_N => "(#{RUBY_VERSION}):%03n:%i> ",
  :PROMPT_S => "(#{RUBY_VERSION}):%03n:%i%l ",
  :PROMPT_C => "(#{RUBY_VERSION}):%03n:%i* ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :MY_PROMPT

##
# My methods
class Object
  def my_methods_only
    my_super = self.class.superclass
    my_super ? methods - my_super.instance_methods : methods
  end

  def my_methods_only_no_mixins
    self.class.ancestors.inject(methods) do |mlist, ancestor|
      mlist = mlist - ancestor.instance_methods unless ancestor.is_a? Class
      mlist
    end
  end
end

# __END__
# vim: filetype=ruby
