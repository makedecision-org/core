# frozen_string_literal: true

module Polls
  module Operations
    class Vote < Libs::Operation
      include Dry::Monads::Try::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[
        vote_repo: 'repositories.vote',
        vote_choice_repo: 'repositories.vote_choice',
      ]

      VALIDATOR = Dry::Validation.JSON do
        required(:account_id, Types::Int).filled
        required(:poll_id, Types::Int).filled
        required(:reason, Types::String).maybe
        required(:variant_ids, Types::Coercible::Array.of(Types::Coercible::Int)).filled
      end

      def call(payload)
        # TODO: use types for typecasting
        payload[:variant_ids] = payload[:variant_ids].map(&:to_i)

        payload = yield VALIDATOR.call(payload).to_either
        vote = yield persist_vote(payload)

        yield persist_user_choice(payload[:variant_ids], vote.id)
        Success(vote)
      end

      private

      def persist_vote(payload)
        raw_reason = payload[:reason]
        # TODO: fill rom and hanami persistance errors
        Try() do
          vote_repo.create(
            poll_id: payload[:poll_id],
            raw_reason: raw_reason,
            reason: payload[:reason],
            account_id: payload[:account_id]
          )
        end
      end

      def persist_user_choice(variant_ids, vote_id)
        # TODO: fill rom and hanami persistance errors
        Try() do
          variant_ids.each { |variant_id| vote_choice_repo.create(vote_id: vote_id, poll_variant_id: variant_id) }
        end
      end
    end
  end
end
