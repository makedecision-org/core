require_relative './poll'

class PollVariant < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :poll_id, Types::Int
    attribute :poll, Types::Entity(Poll)

    attribute :title,     Types::String
    attribute :prioroty,  Types::Int

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
