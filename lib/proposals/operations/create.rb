# frozen_string_literal: true

module Proposals
  module Operations
    class Create < Libs::Operation
      include Import[
        'libs.markdown_parser',
        proposal_repository: 'repositories.proposal',
        org_repository: 'repositories.organisation'
      ]

      def call(title:, body:, organisation_slug:, team_id:)
        org_id = org_repository.find_id(organisation_slug)
        raw_body = body
        body = markdown_parser.call(raw_body)

        Success(
          proposal_repository.create(
            title: title,
            team_id: team_id,
            organisation_id: org_id,
            raw_body: raw_body,
            body: body
          )
        )
      end
    end
  end
end
