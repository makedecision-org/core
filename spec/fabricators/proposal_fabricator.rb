Fabricator(:proposal) do
  title 'proposal title'

  organisation_id { Fabricate.create(:organisation).id }
  team_id { Fabricate.create(:team).id }
end
