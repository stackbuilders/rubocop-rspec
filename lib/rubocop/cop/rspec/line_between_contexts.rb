# encoding: utf-8

module RuboCop
  module Cop
    module RSpec
      # Checks for CR between level context.
      #
      # @example
      #   # bad
      #   context 'when someting' do
      #     it { is_expected.to respond_with 200 }
      #   end
      #   context 'when someting else' do
      #     it { is_expected.to respond_with 401 }
      #   end
      #
      #   #good
      #   context 'when someting' do
      #     it { is_expected.to respond_with 200 }
      #   end
      #
      #   context 'when someting else' do
      #     it { is_expected.to respond_with 401 }
      #   end

      class LineBetweenContexts < Cop
        include RuboCop::RSpec::TopLevelContext

        MESSAGE = 'Missing blank line between context blocks'

        def on_top_level_context(node, _args)
          return if single_top_level_context?

          return unless context_statement_line_in_between node

          add_offense(node, :expression, MESSAGE)
        end
      end
    end
  end
end
