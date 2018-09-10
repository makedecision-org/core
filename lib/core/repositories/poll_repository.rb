class PollRepository < Hanami::Repository
  associations do
    belongs_to :proposal
  end
end
