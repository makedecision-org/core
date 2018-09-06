# frozen_string_literal: true

module Teams
  module Operations
    class Read < Libs::Operation
      include Import[team_repository: 'repositories.team']

      def call(org_slug:, id:)
        org = team_repository.find(id)
        org ? Success(org) : Failure(:not_found)
      end
    end
  end
end
