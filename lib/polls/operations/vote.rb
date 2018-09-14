# frozen_string_literal: true

module Polls
  module Operations
    class Vote < Libs::Operation
      include Dry::Monads::Do.for(:call)

      # include Import[
      #   poll_repo: 'repositories.poll',
      # ]

      VALIDATOR = Dry::Validation.JSON do
      end

      def call(payload:)
        Success(Poll.new)
      end
    end
  end
end
