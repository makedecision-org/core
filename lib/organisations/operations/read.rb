module Organisations
  module Operations
    class Read < Libs::Operation
      include Import[org_repository: 'repositories.organisation']

      def call(id:)
        org = org_repository.find(id)
        org ? Success(org) : Failure(:not_found)
      end
    end
  end
end

