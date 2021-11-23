require 'glimmer-dsl-specification'

class Person
  attr_reader :first_name, :last_name
  
  def initialize(first_name: , last_name: )
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

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
    
    use_case('Verify Multiple Facts') {
      scenario 'person name consists of first name and last name' do
        person = Person.new(first_name: 'Bob', last_name: 'Winfrey')
        
        fact { person.first_name == 'Bob' }
        fact { person.last_name == 'Winfrey' }
        person.name == 'Bob Winfrey'
      end
    }
  }
end
