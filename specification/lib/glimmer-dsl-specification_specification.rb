require 'glimmer-dsl-specification'

module Glimmer::Specification
  specification('Glimmer DSL for Specification') {
    use_case('Compare Two Objects for Equality') {
      scenario 'Same-content strings are equal' do
        'string' == 'string'
      end
      
      scenario 'Different-content strings are not equal' do
        'string1' != 'string2'
      end
      
      scenario 'Same-number integers are equal' do
        1 == 1
      end
      
      scenario 'Different-number integers are not equal' do
        1 != 2
      end
    }
  }
end
