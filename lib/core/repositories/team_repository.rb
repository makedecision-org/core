class TeamRepository < Hanami::Repository
  relations :teams, :organisations
  associations do
    belongs_to :organisation
    has_many :proposals
  end

  def all_for_organisation(org_slug)
    root
      .join(:organisation)
      .where(organisations[:slug].qualified => org_slug)
      .map_to(Team).to_a
  end
end
