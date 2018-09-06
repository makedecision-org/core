# frozen_string_literal: true

module Web::Controllers::Comments
  class Create
    include Web::Action
    include Import[operation: 'proposals.operations.create_comment']

    def call(params)
      result = operation.call(**params.to_h.slice(:proposal_id, :body))
      redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.proposal_id)
    end
  end
end
