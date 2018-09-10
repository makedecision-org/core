class VoteRepository < Hanami::Repository
  associations do
    belongs_to :poll
  end
end
