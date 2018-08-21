module Web::Controllers::ProposalStatuses
  class Update
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.update_status']

    def call(params)
      case result = operation.call(**params)
      when Success
        redirect_to routes.proposal_path(result.value!)
      when Failure
        redirect_to routes.proposal_path(params[:id])
      end
    end
  end
end
