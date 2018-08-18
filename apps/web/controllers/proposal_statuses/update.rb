module Web::Controllers::ProposalStatuses
  class Update
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.update_status']

    def call(params)
      operation.call(id: params[:id], **params)
      redirect_to routes.proposal_path(params[:id])
    end
  end
end
