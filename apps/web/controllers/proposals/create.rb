module Web::Controllers::Proposals
  class Create
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.create']

    expose :proposal

    def call(params)
      payload = {
        organisation_slug: params[:organisation_id],
        team_id: params[:proposal][:team_id],
        title: params[:proposal][:title],
        body: params[:proposal][:body]
      }

      case result = operation.call(payload)
      when Success
        redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.id)
      when Failure
        proposal = Proposal.new(title: params[:title], body: params[:body])

        self.body = Web::Views::Proposals::New.render(format: format, proposal: proposal,
          errors: result.failure, params: params)
          # errors: result.failure, params: params, updated_csrf_token: set_csrf_token)
      end
    end
  end
end
