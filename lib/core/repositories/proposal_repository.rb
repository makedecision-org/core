class ProposalRepository < Hanami::Repository
  associations do
    has_many :variants
  end

  def find_with_variants(id)
    aggregate(:variants).by_pk(id).map_to(Proposal).one
  end
end
