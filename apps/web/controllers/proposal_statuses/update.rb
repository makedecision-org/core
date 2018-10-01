# frozen_string_literal: true

module Web::Controllers::ProposalStatuses
  class Update
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.update_status']

    def call(params)
      # TODO: drop unnecessary case
      operation.call(**params)
      redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:id])
    end
  end
end
