# frozen_string_literal: true

require_relative './variant'
require_relative './comment'

# Hack for reqursion entity loading
class Team < Hanami::Entity
end

class Poll < Hanami::Entity
end

class Proposal < Hanami::Entity
  OPEN = 'open'
  APPROVED = 'approved'
  DENIED = 'denied'

  attributes do
    attribute :id, Types::Int

    attribute :organisation_id, Types::Int
    attribute :team_id, Types::Int

    attribute :title, Types::String
    attribute :body, Types::String
    attribute :raw_body, Types::String

    attribute :conclusions, Types::String
    attribute :raw_conclusions, Types::String

    attribute :status, ::Types::ProposalStatuses

    attribute :team, Types::Entity(Team)
    attribute :variants, Types::Collection(Variant)
    attribute :comments, Types::Collection(Comment)
    attribute :polls, Types::Collection(Poll)

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def open?
    status == OPEN
  end

  def approved?
    status == APPROVED
  end

  def denied?
    status == DENIED
  end
end
