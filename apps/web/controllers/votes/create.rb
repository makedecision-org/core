# frozen_string_literal: true

module Web::Controllers::Votes
  class Create
    include Web::Action
    include Import[operation: 'polls.operations.vote']

    def call(params)
      operation.call(
        account_id: current_account.id,
        poll_id: params[:poll_id],
        reason: params[:reason],
        variant_ids: params[:variant_ids]
      )
      redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:proposal_id])
    end
  end
end
