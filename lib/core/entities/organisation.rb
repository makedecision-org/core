# frozen_string_literal: true

require_relative './team'
require_relative './proposal'

class Organisation < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :slug, Types::String

    attribute :title,           Types::String
    attribute :description,     Types::String
    attribute :raw_description, Types::String

    attribute :public, Types::Bool

    attribute :teams, Types::Collection(Team)
    attribute :proposals, Types::Collection(Proposal)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def public?
    !!public
  end
end
