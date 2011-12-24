# coding: utf-8

Pry.config.prompt = [
  proc {|target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[#{pry.input_array.size}] #{RUBY_VERSION}(#{Pry.view_clip(target_self)})#{nested}> "
  },
  proc {|targe_self, nest_level, pry|
    nested = (nest_level.zero?) ?  '' : ":#{nest_level}"
    "[#{pry.input_array.size}] #{RUBY_VERSION}(#{Pry.view_clip(target_self)})#{nested}* "
  }
]
