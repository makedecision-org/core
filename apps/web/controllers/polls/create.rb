# frozen_string_literal: true

module Web::Controllers::Polls
  class Create
    include Web::Action

    include Dry::Monads::Result::Mixin
    include Import[operation: 'polls.operations.create']

    def call(params)
      case result = operation.call(payload: params[:poll].to_h)
      when Success
        redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.proposal_id)
      when Failure
        # TODO: redirect to new poll page
        redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:proposal_id])
      end
    end
  end
end
