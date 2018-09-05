module Teams
  module Operations
    class List < Libs::Operation
      include Import[team_repository: 'repositories.team']

      def call(org_slug:)
        Success(team_repository.all_for_organisation(org_slug))
      end
    end
  end
end

