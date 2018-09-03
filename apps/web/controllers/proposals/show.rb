module Web::Controllers::Proposals
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.read']

    expose :proposal

    def call(params)
      case result = operation.call(id: params[:id])
      when Success
        @proposal = result.value!
      when Failure
        redirect_to routes.organisation_path(params[:organisation_id])
      end
    end
  end
end
