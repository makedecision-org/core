# frozen_string_literal: true

class VoteRepository < Hanami::Repository
  associations do
    belongs_to :poll

    has_many :vote_choices
  end
end
