# frozen_string_literal: true

class Account < Hanami::Entity
end

class AuthIdentity < Hanami::Entity
  attributes do
    attribute :id, Types::Int
    attribute :account_id, Types::Int
    attribute :account, Types::Entity(Account)

    attribute :token, Types::String
    attribute :uid, Types::String
    attribute :type, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
