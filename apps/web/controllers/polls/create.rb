# frozen_string_literal: true

module Web::Controllers::Polls
  class Create
    include Web::Action

    include Dry::Monads::Result::Mixin
    include Import[operation: 'polls.operations.create']

    def call(params)
      payload = { author_id: current_account.id }.merge!(params[:poll].to_h)
      case result = operation.call(payload: payload)
      when Success
        redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.proposal_id)
      when Failure
        # TODO: redirect to new poll page
        redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:proposal_id])
      end
    end
  end
end
