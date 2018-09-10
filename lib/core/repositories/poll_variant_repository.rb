class PollVariantRepository < Hanami::Repository
  associations do
    belongs_to :poll
  end
end
