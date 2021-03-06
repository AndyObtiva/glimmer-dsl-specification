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
      class Scenario < Element
        def initialize(parent, keyword, *args, &block)
          @executable = true
          super
        end
        
        def fact(&block)
          new_fact = Fact.new(self, 'fact', [], &block)
          new_fact.run
          @verified &&= new_fact.verified?
        end
        
        def run
          @verified = true
          own_block_verified = Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Specification::ElementExpression.new, @keyword, &@block)
          @verified &&= own_block_verified if own_block_verified.is_a?(TrueClass) || own_block_verified.is_a?(FalseClass)
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
