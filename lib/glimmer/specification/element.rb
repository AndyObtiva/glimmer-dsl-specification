# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
        if @verified
          puts Colours::GREEN + "VERIFIED: #{to_s}"
        else
          puts Colours::RED + "NOT VERIFIED: #{to_s}"
        end
      end
      
      def to_s
        ancestors.reverse.map(&:title).join(' - ')
      end
    end
  end
end

Dir[File.expand_path('./element/*.rb', __dir__)].each {|f| require f}
