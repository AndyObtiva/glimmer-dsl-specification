require 'glimmer-dsl-specification'

module Glimmer::Specification
  specification('Glimmer DSL for Specification') {
    scenario 'Same-content strings are equal' do
      'string' == 'string'
    end
#     use_case('Compare Two Objects for Equality') {
#     }
  }
end
