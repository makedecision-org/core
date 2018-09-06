# frozen_string_literal: true

Fabricator(:team) do
  title 'team title'
  body 'team body'

  organisation_id { Fabricate.create(:organisation).id }
end
