module Web::Controllers::Teams
  class Create
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'teams.operations.create']

    expose :team

    def call(params)
      payload = {
        organisation_id: params[:team][:organisation_id],
        title: params[:team][:title],
        body: params[:team][:body]
      }

      case result = operation.call(payload)
      when Success
        redirect_to routes.organisation_team_path(params[:organisation_id], result.value!.id)
      when Failure
        team = Team.new(title: payload[:title], body: payload[:body])

        # TODO: fix it
        self.body = Web::Views::Teams::New.render(
          format: format, team: team, organisation: Organisation.new(id: payload[:organisation_id], slug: params[:organisation_id]),
          errors: result.failure, params: params
        )
          # errors: result.failure, params: params, updated_csrf_token: set_csrf_token)
      end
    end
  end
end
