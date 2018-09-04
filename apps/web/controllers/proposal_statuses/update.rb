module Web::Controllers::ProposalStatuses
  class Update
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.update_status']

    def call(params)
      # TODO: drop unnecessary case
      case result = operation.call(**params)
      when Success
        redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!)
      when Failure
        redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:id])
      end
    end
  end
end
