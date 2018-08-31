class OrganisationRepository < Hanami::Repository
  def find_by_slug(slug)
    root.where(slug: slug).map_to(Organisation).one
  end
end
