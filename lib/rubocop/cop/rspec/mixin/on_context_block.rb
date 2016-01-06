# encoding: utf-8

module RuboCop
  module Cop
    module RSpec
      module OnContextBlock
        def on_block(node)
          if is_context?(node)
            on_context(node)
          end
        end

        def is_context?(node)
          block, _args, _body = *node
          _receiver, block_name, *_args = *block
          block_name == :context
        end
      end
    end
  end
end
