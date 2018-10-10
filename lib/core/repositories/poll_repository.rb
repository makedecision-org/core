# frozen_string_literal: true

class PollRepository < Hanami::Repository
  associations do
    belongs_to :proposal

    has_many :poll_variants
    has_many :votes
  end

  def find_with_all(id)
    aggregate(:poll_variants, votes: :vote_choices).by_pk(id).map_to(Poll).one
  end
end
