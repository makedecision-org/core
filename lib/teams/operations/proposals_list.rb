module Teams
  module Operations
    class ProposalsList < Libs::Operation
      include Import[proposal_repository: 'repositories.proposal']

      def call(team_id:)
        Success(proposal_repository.grupped_by_status_for_team(team_id))
      end
    end
  end
end

