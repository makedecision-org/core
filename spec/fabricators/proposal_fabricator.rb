Fabricator(:proposal) do
  title 'proposal title'

  organisation_id { Fabricate.create(:organisation).id }
end
