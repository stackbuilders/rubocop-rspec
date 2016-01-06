# encoding: utf-8

module RuboCop
  module Cop
    module RSpec
      class LineBetweenContexts < Cop
        include OnContextBlock

        MESSAGE = 'Missing blank line between context blocks'

        def on_context(node)
          # Retreive the previous sibling
          # of node, and if it's a context,
          # check that there is CR inbetween
           return unless node.parent

           nodes = [prev_context(node), node]
           return if blank_lines_between?(*nodes)
           add_offense(node, :keyword)
        end

        private

        def prev_context(node)
          return nil unless node.sibling_index > 0
          prev_node = node.parent.children[node.sibling_index -1]
          return nil unless is_context?(prev_node)
          prev_node
        end

        def blank_lines_between?(first_context_node, second_context_node)
          lines_between_contexts(first_context_node, second_context_node).any?(&:blank?)
        end

        def lines_between_contexts(first_context_node, second_context_node)
          line_range = (first_context_node.loc.end.line)..(second_context_node.loc.keyword.line - 2)
          processed_source.lines[line_range]
        end
      end
    end
  end
end
