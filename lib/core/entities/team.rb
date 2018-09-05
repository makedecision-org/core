require_relative './proposal'

class Team < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :organisation_id, Types::Int

    attribute :title,    Types::String # TODO: add constrain for uniq
    attribute :body,     Types::String
    attribute :raw_body, Types::String

    attribute :proposals, Types::Collection(Proposal)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
