module Glimmer
  module Specification
    class Element
      class Specification < Element
        def post_add_content
          run
        end
        
        def run
          scenarios.each(&:run)
        end
      end
    end
  end
end
