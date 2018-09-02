class Team < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :organisation_id, Types::Int

    attribute :title,           Types::String
    attribute :body,     Types::String
    attribute :raw_body, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
