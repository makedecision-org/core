# frozen_string_literal: true

class Comment < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :proposal_id, Types::Int

    attribute :body, Types::String
    attribute :raw_body, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
