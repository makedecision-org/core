# frozen_string_literal: true

module Polls
  module Operations
    class Read < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[
        poll_repo: 'repositories.poll',
      ]

      def call(id:)
        poll = poll_repo.find(id)
        poll ? Success(poll) : Failure(:not_found)
      end
    end
  end
end
