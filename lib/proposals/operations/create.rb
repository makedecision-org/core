module Proposals
  module Operations
    class Create < Libs::Operation
      include Import[
        'libs.markdown_parser',
        proposal_repository: 'repositories.proposal'
      ]

      def call(title:, body:)
        raw_body = body
        body = markdown_parser.call(raw_body)
        Success(proposal_repository.create(title: title, raw_body: raw_body, body: body))
      end
    end
  end
end
