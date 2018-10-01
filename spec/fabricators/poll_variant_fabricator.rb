# frozen_string_literal: true

Fabricator(:poll_variant) do
  title 'lets select something'
  prioroty 0

  poll_id { Fabricate.create(:poll).id }
end
