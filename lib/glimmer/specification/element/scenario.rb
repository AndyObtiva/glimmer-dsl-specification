module Glimmer
  module Specification
    class Element
      class Scenario < Element
        def run
          @verified = @block.call
          if @verified
            puts "VERIFIED: #{to_s}"
          else
            puts "NOT VERIFIED: #{to_s}"
          end
        end
      end
    end
  end
end
