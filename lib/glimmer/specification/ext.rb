# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

using ArrayIncludeMethods

module Glimmer
  module Specification
    module Ext
      class << self
        attr_accessor :log_failure_of_method_in_progress
        alias log_failure_of_method_in_progress? log_failure_of_method_in_progress
        
        def log_failure_of_method(klass, method_name, method_alias = nil, &output_formatter)
          klass.class_eval do
            method_alias ||= "without_glimmer_#{method_name}"
            method_alias = "#{name.split('::').last.underscore}_#{method_alias}"
            alias_method method_alias, method_name
            define_method(method_name) do |*args|
              logging = false
              logging = Ext.log_failure_of_method_in_progress = true if !frozen? && !Ext.log_failure_of_method_in_progress?
              send(method_alias, *args).tap do |result|
                unless frozen?
                  if logging
                    output = output_formatter&.call(self, method_name, args)
                    output ||= "#{self.inspect}.#{method_name}#{"(#{args.map(&:inspect).join(',')})" unless args.array_without_glimmer_empty?}"
                    puts Colours::RED + "FAILED: #{output}" if Glimmer::Specification::Element::Fact.fact_block_in_progress && !result
                    Ext.log_failure_of_method_in_progress = false
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

Dir[File.expand_path('./ext/*.rb', __dir__)].each {|f| require f}
