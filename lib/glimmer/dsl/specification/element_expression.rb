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
