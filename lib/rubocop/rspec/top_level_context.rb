# encoding: utf-8

module RuboCop
  module RSpec
    # Helper methods for top level context cops
    module TopLevelContext
      def on_send(node)
        return unless respond_to?(:on_top_level_context)
        return unless top_level_context?(node)

        _receiver, _method_name, *args = *node

        on_top_level_context(node, args)
      end

      private

      def top_level_context?(node)
        _receiver, method_name, *_args = *node
        return false unless method_name == :context

        top_level_nodes.include?(node)
      end

      def top_level_nodes
        nodes = context_statement_children(root_node)
      end

      def root_node
        processed_source.ast
      end

      def single_top_level_context?
        top_level_nodes.count == 1
      end

      def context_statement_children(node)
        node_children(node).select do |element|
          element.type == :send && element.children[1] == :context
        end
      end

      def context_statement_line_in_between(node)
        node.children.select do |element|
          # e.is_a? Parser::AST::Node && element.type == :send && element.children[1] == :context
          # TO DO
        end
      end

      def node_children(node)
        node.children.select { |e| e.is_a? Parser::AST::Node }
      end
    end
  end
end
