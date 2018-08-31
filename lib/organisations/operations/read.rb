module Organisations
  module Operations
    class Read < Libs::Operation
      include Import[org_repository: 'repositories.organisation']

      def call(slug:)
        org = org_repository.find_by_slug(slug)
        org ? Success(org) : Failure(:not_found)
      end
    end
  end
end

