require_relative './poll'

class Vote < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :poll_id, Types::Int
    attribute :poll, Types::Entity(Poll)

    attribute :reason,     Types::String
    attribute :raw_reason, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
