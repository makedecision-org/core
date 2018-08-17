class ProposalRepository < Hanami::Repository
  associations do
    has_many :variants
  end
end
