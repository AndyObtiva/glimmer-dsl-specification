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

module Glimmer
  module Specification
    class Element
      class Fact < Element
        class << self
          attr_accessor :fact_block_in_progress
        end
      
        def initialize(parent, keyword, *args, &block)
          @executable = true
          super
          source_code = PutsDebuggerer::SourceFile.new(@block.source_location.first).source(1, @block.source_location.last)
          @title = source_code.strip
        end
        
        def run
          Fact.fact_block_in_progress = true
          @verified = @block.call
          Fact.fact_block_in_progress = false
          if @verified
            puts Colours::GREEN + "VERIFIED: #{to_s}"
          else
            puts Colours::RED + "NOT VERIFIED: #{to_s}"
          end
        end
      end
    end
  end
end
