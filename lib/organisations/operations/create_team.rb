# frozen_string_literal: true

module Organisations
  module Operations
    class CreateTeam < Libs::Operation
      include Import[team_repository: 'repositories.team']

      def call(title:, body:, organisation_id:)
        Success(team_repository.create(title: title, body: body, organisation_id: organisation_id))
      end
    end
  end
end
