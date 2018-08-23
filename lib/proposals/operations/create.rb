module Proposals
  module Operations
    class Create < Libs::Operation
      include Import[proposal_repository: 'repositories.proposal']

      def call(title:, body:)
        Success(proposal_repository.create(title: title, body: body))
      end
    end
  end
end
