# frozen_string_literal: true

class VoteChoiceRepository < Hanami::Repository
  associations do
    belongs_to :vote
    belongs_to :poll_variant
  end
end
