class OrganisationRepository < Hanami::Repository
  associations do
    has_many :teams
  end

  def find_by_slug(slug)
    root.where(slug: slug).map_to(Organisation).one
  end
end
