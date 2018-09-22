# frozen_string_literal: true

module Web::Controllers::Polls
  class New
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.read']

    expose :poll, :proposal

    def call(params)
      @poll = Poll.new(variants: [])

      case result = operation.call(id: params[:proposal_id])
      when Success
        @proposal = result.value!
      when Failure
        redirect_to routes.organisation_path(params[:organisation_id])
      end
    end
  end
end
