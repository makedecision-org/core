# frozen_string_literal: true

Fabricator(:poll) do
  title 'lets select something'
  description 'because I can'
  raw_description 'because I can'
  type 'choice'

  proposal_id { Fabricate.create(:proposal).id }
  organisation_id { Fabricate.create(:organisation).id }
end
