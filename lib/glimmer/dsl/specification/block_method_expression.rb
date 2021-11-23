require 'glimmer/dsl/expression'

module Glimmer
  module DSL
    module Specification
      class BlockMethodExpression < Expression
        def can_interpret?(parent, keyword, *args, &block)
          parent.respond_to?(keyword) and
            block_given?
        end
        
        def interpret(parent, keyword, *args, &block)
          parent.send("#{keyword}", &block)
        end
      end
    end
  end
end
