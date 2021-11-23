module Glimmer
  module Specification
    class Element
      class Specification < Element
        def post_add_content
          run
          super
        end
      end
    end
  end
end
