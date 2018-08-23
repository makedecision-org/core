module Web::Controllers::Proposals
  class Create
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.create']

    expose :proposal

    def call(params)
      case result = operation.call(title: params[:proposal][:title], body: params[:proposal][:body])
      when Success
        redirect_to routes.proposal_path(result.value!.id)
      when Failure
        proposal = Proposal.new(title: params[:title], body: params[:body])

        self.body = Web::Views::Proposals::New.render(format: format, proposal: proposal,
          errors: result.failure, params: params)
          # errors: result.failure, params: params, updated_csrf_token: set_csrf_token)
      end
    end
  end
end
