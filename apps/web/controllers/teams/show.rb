# frozen_string_literal: true

module Web::Controllers::Teams
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[
      operation: 'teams.operations.read',
      proposals_list_operation: 'teams.operations.proposals_list'
    ]

    expose :team, :proposals

    def call(params)
      case result = operation.call(org_slug: params[:organisation_id], id: params[:id])
      when Success
        @team = result.value!
        @proposals = proposals_list_operation.call(team_id: params[:id]).value!
      when Failure
        redirect_to routes.organisation_path(params[:organisation_id])
      end
    end
  end
end
