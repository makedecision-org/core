class Comment < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :proposal_id, Types::Int

    attribute :name, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
