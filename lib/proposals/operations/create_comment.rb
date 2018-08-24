module Proposals
  module Operations
    class CreateComment < Libs::Operation
      include Import[comment_repository: 'repositories.comment']

      def call(body:, proposal_id:)
        # TODO: check name on not empty string and proposal_id on exist
        comment = comment_repository.create(body: body, proposal_id: proposal_id)
        Success(comment)
      end
    end
  end
end
