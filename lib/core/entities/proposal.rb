require_relative './variant'

class Proposal < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :title, Types::String
    attribute :body, Types::String

    attribute :variants, Types::Collection(Variant)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
