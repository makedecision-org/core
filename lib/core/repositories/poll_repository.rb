class PollRepository < Hanami::Repository
  associations do
    belongs_to :proposal
    has_many :poll_variants
  end
end
