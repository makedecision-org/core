module Proposals
  module Operations
    class List < Libs::Operation
      include Import[proposal_repository: 'repositories.proposal']

      def call
        Success(proposal_repository.all)
      end
    end
  end
end
