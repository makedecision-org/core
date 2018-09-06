# frozen_string_literal: true

module Web::Controllers::Variants
  class Destroy
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'variants.operations.delete']

    def call(params)
      case result = operation.call(id: params[:id])
      when Success
        redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.proposal_id)
      when Failure
        halt 404
      end
    end
  end
end
