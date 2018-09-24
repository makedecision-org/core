# frozen_string_literal: true

require_relative './auth_identity'

class Account < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :auth_identities, Types::Collection(AuthIdentity)

    attribute :name, Types::String
    attribute :uuid, Types::String
    attribute :login, Types::String
    attribute :email, Types::String
    attribute :avatar_url, Types::String
    attribute :bio, Types::String
    attribute :role, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
