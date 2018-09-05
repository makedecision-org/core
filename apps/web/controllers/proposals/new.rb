module Web::Controllers::Proposals
  class New
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[team_list_operation: 'teams.operations.list']

    expose :proposal, :teams

    def call(params)
      @proposal = Proposal.new
      @teams = team_list_operation.call(org_slug: params[:organisation_id]).value!
    end
  end
end
