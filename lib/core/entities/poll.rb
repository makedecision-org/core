require_relative './proposal'

class Poll < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :proposal_id, Types::Int
    attribute :proposal,    Types::Entity(Proposal)

    attribute :title,           Types::String
    attribute :description,     Types::String
    attribute :raw_description, Types::String

    attribute :type,            Types::String
    attribute :anonymous, Types::Bool

    attribute :vote_data, Types::Collection(Types::Coercible::Hash)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
    attribute :closed_at, Types::Time
  end
end