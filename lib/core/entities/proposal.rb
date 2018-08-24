require_relative './variant'
require_relative './comment'

class Proposal < Hanami::Entity
  OPEN = 'open'
  APPROVED = 'approved'
  DENIED = 'denied'

  attributes do
    attribute :id, Types::Int

    attribute :title, Types::String
    attribute :body, Types::String
    attribute :raw_body, Types::String

    attribute :conclusions, Types::String
    attribute :raw_conclusions, Types::String

    attribute :status, ::Types::ProposalStatuses

    attribute :variants, Types::Collection(Variant)
    attribute :comments, Types::Collection(Comment)

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
