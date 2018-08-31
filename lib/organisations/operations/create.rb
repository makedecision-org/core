module Organisations
  module Operations
    class Create < Libs::Operation
      include Import[org_repository: 'repositories.organisation']

      def call(title:, description:)
        Success(org_repository.create(title: title, description: description))
      end
    end
  end
end
