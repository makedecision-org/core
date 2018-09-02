class OrganisationRepository < Hanami::Repository
  associations do
    has_many :teams
    has_many :proposals
  end

  def find_by_slug(slug)
    # TODO: specs for aggregate
    aggregate(:teams, :proposals).where(slug: slug).map_to(Organisation).one
  end
end
