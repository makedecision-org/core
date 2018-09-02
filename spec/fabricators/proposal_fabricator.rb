Fabricator(:proposal) do
  title 'proposal title'
  title 'proposal body'
  conclusions 'proposal conclusions'

  organisation_id { Fabricate.create(:organisation).id }
end
