module Web::Controllers::Proposals
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.read']

    expose :proposal

    def call(_params)
      case result = operation.call(id: params[:id])
      when Success
        @proposal = result.value!
      when Failure
        redirect_to routes.proposals_path
      end
    end
  end
end
