# frozen_string_literal: true

require_relative './poll'

# Hack for reqursion entity loading
class VoteChoice < Hanami::Entity
end

class PollVariant < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :poll_id, Types::Int
    attribute :poll, Types::Entity(Poll)

    attribute :title,     Types::String
    attribute :prioroty,  Types::Int

    attribute :vote_choices, Types::Collection(VoteChoice)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
