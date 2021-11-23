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
