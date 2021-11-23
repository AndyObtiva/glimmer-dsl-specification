module Glimmer
  module Specification
    class Element
      class << self
        def element_exist?(keyword)
          constants.include?(element_class_name(keyword)) && element_class(keyword).respond_to?(:new)
        end
      
        def element_class(keyword)
          const_get(element_class_name(keyword))
        end
        
        def element_class_name(keyword)
          keyword.to_s.camelcase(:upper).to_sym
        end
      end
      
      attr_reader :parent, :keyword, :args, :block
      attr_accessor :title
    
      def initialize(parent, keyword, *args, &block)
        @parent = parent
        @keyword = keyword
        @args = args
        @title = @args.first
        @block = block
        @children = children
        @parent&.post_initialize_child(self)
        post_add_content if @block.nil?
      end
      
      def children
        @children ||= []
      end
      
      def verified?
        @verified
      end
      
      def content_added?
        @content_added
      end
      
      # subclasses may override (e.g. Scenario)
      def executable?
        !!@executable
      end
      
      def scenarios
        children.map do |child|
          child.is_a?(Scenario) ? child : child.scenarios
        end.flatten
      end
      
      # ancestors including self ordered from closest to farthest
      def ancestors
        if @ancestors.nil?
          @ancestors = [self]
          current = self
          while current.parent
            current = current.parent
            @ancestors << current
          end
        end
        @ancestors
      end
      
      def post_initialize_child(child)
        children << child
      end
      
      def post_add_content
        # No Op (subclasses may override to do something at the closing of the element)
        @content_added = true
      end
      
      # Enables re-opening content and adding new shapes
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Specification::ElementExpression.new, @keyword, &block)
      end
      
      # runs children by default. subclasses may override.
      def run
        children.each(&:run)
        @verified = children.all?(&:verified?)
        puts "VERIFIED: #{to_s}" if @verified
      end
      
      def to_s
        ancestors.reverse.map(&:title).join(' - ')
      end
    end
  end
end

Dir[File.expand_path('./element/*.rb', __dir__)].each {|f| require f}
