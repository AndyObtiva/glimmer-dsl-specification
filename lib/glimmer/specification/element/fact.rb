module Glimmer
  module Specification
    class Element
      class Fact < Element
        def initialize(parent, keyword, *args, &block)
          @executable = true
          super
          source_code = PutsDebuggerer::SourceFile.new(@block.source_location.first).source(1, @block.source_location.last)
          @title = source_code.strip
        end
        
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
