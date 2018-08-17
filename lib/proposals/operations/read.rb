module Proposals
  module Operations
    class Read < Libs::Operation
      def call(id:)
        Success(Proposal.new)
      end
    end
  end
end
