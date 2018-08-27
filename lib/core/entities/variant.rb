class Variant < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :proposal_id, Types::Int

    attribute :name, Types::String

    attribute :body, Types::String
    attribute :raw_body, Types::String

    attribute :positive_traits, Types::Collection(Types::Coercible::Hash)
    attribute :negative_traits, Types::Collection(Types::Coercible::Hash)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
