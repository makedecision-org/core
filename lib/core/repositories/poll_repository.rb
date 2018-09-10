class PollRepository < Hanami::Repository
  associations do
    belongs_to :proposal

    has_many :poll_variants
    has_many :votes
  end
end
