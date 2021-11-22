require 'glimmer/dsl/engine'
Dir[File.expand_path('*_expression.rb', __dir__)].each {|f| require f}

module Glimmer
  module DSL
    module Specification
      Engine.add_dynamic_expressions(
        Specification,
        %w[
          attribute
          element
        ]
      )
    end
  end
end
