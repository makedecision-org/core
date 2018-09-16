# frozen_string_literal: true

module Polls
  module Operations
    class Create < Libs::Operation
      include Dry::Monads::Do.for(:call)

      include Import[
        poll_repo: 'repositories.poll',
        poll_variant_repo: 'repositories.poll_variant',
      ]

      VALIDATOR = Dry::Validation.JSON do
        required(:proposal_id, Types::Int).filled
        required(:type, Types::PollTypes).filled(included_in?: Poll::TYPES)
        required(:title, Types::String).filled
        optional(:description, Types::String).filled

        required(:variants).each do
          schema do
            required(:title, Types::String).filled
            optional(:prioroty, Types::Int).filled
          end
        end
      end

      def call(payload:)
        payload = yield VALIDATOR.call(payload).to_either
        poll = yield create_poll(payload)
        yield create_poll_variants(poll_id: poll.id, **payload)

        Success(poll)
      end

      private

      def create_poll(proposal_id:, type:, title:, description:, **_payload)
        Success(poll_repo.create(
                  proposal_id: proposal_id, type: type, title: title, description: description
                ))
      end

      def create_poll_variants(poll_id:, variants:, **_payload)
        Success(variants.map { |variant| poll_variant_repo.create(poll_id: poll_id, prioroty: 1, **variant) })
      end
    end
  end
end
