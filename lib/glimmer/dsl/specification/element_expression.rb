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

require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/dsl/top_level_expression'
require_relative '../../specification/element'

module Glimmer
  module DSL
    module Specification
      class ElementExpression < Expression
        include ParentExpression
        include TopLevelExpression
        
        def can_interpret?(parent, keyword, *args, &block)
          Glimmer::Specification::Element.element_exist?(keyword)
        end
        
        def interpret(parent, keyword, *args, &block)
          Glimmer::Specification::Element.element_class(keyword).new(parent, keyword, *args, &block) unless parent&.content_added?
        end
        
        def add_content(element, keyword, *args, &block)
          result = super unless element.executable? && !element.content_added?
          element.post_add_content
          result
        end
      end
    end
  end
end
