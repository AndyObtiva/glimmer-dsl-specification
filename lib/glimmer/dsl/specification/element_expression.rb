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
          Glimmer::Specification::Element.element_class(keyword).new(parent, keyword, *args, &block)
        end
        
        def add_content(element, keyword, *args, &block)
          super
          element.post_add_content
        end
      end
    end
  end
end
