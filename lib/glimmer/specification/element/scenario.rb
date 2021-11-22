module Glimmer
  module Specification
    class Element
      class Scenario < Element
        def run
          if @block.call
            puts "FACT VERIFIED: #{to_s}"
          else
            puts "FACT NOT VERIFIED: #{to_s}"
          end
        end
        
        def to_s
          ancestors.reverse.map(&:title).join(' - ')
        end
      end
    end
  end
end
