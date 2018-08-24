class ProposalRepository < Hanami::Repository
  associations do
    has_many :variants
    has_many :comments
  end

  def find_with_variants(id)
    aggregate(:variants, :comments).where(id: id).map_to(Proposal).one
  end
end
