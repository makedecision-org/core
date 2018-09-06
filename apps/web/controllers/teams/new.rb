# frozen_string_literal: true

module Web::Controllers::Teams
  class New
    include Web::Action
    include Import[org_operation: 'organisations.operations.read']

    expose :organisation, :team

    def call(params)
      @team = Team.new
      @organisation = org_operation.call(slug: params[:organisation_id]).value_or(Organisation.new)
    end
  end
end
