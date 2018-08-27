module Proposals
  module Operations
    class CreateComment < Libs::Operation
      include Import[
        'libs.markdown_parser',
        comment_repository: 'repositories.comment'
      ]

      def call(body:, proposal_id:)
        raw_body = body
        body = markdown_parser.call(raw_body)

        # TODO: check name on not empty string and proposal_id on exist
        comment = comment_repository.create(raw_body: raw_body, body: body, proposal_id: proposal_id)
        Success(comment)
      end
    end
  end
end
