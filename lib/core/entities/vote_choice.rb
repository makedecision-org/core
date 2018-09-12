# frozen_string_literal: true

require_relative './vote'
require_relative './poll_variant'

class VoteChoice < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :vote_id, Types::Int
    attribute :vote, Types::Entity(Vote)

    attribute :poll_variant_id, Types::Int
    attribute :poll_variant, Types::Entity(PollVariant)

    attribute :score, Types::Int

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
