module Proposals
  module Operations
    class Read < Libs::Operation
      include Import[proposal_repository: 'repositories.proposal']

      def call(id:)
        proposal = proposal_repository.find_with_variants(id)
        proposal ? Success(proposal) : Failure(:not_found)
      end
    end
  end
end
