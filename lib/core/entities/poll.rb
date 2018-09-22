# frozen_string_literal: true

require_relative './proposal'
require_relative './poll_variant'

class PollVariant < Hanami::Entity
end

# Types:
#
#   * choice (default) - Offer a choice. Enter a question and provide some options for people to choose from. People vote for one or more options - depending on if you allow single or multiple choice.
#   * agreement - Seek collective agreement
#   * check - Make an offer or ask people to take some action. Think of it as the online equilavent of asking a room of people “Please raise your hand if you…”.
#   * time - Find a time to meet
#
# Future types:
#
#   * Dot vote - Everyone gets a number of dots to allocate against a set of options to represent their priorities. This can build a more detailed picture than a simple poll.
#

class Poll < Hanami::Entity
  TYPES = %w[choice agreement check time].freeze

  attributes do
    attribute :id, Types::Int
    attribute :proposal_id, Types::Int
    attribute :proposal,    Types::Entity(Proposal)

    attribute :title,           Types::String
    attribute :description,     Types::String
    attribute :raw_description, Types::String

    attribute :type,      Types::String
    attribute :anonymous, Types::Bool

    attribute :vote_data, Types::Collection(Types::Coercible::Hash).default([])
    attribute :poll_variants, Types::Collection(PollVariant).default([])

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
    attribute :closed_at, Types::Time
  end
end
