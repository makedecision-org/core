module Organisations
  module Operations
    class List < Libs::Operation
      include Import[org_repository: 'repositories.organisation']

      def call
        Success(org_repository.all)
      end
    end
  end
end
