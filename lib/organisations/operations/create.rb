# frozen_string_literal: true

module Organisations
  module Operations
    class Create < Libs::Operation
      include Import[org_repository: 'repositories.organisation']

      def call(title:, slug:, description:)
        Success(org_repository.create(title: title, slug: slug, description: description))
      end
    end
  end
end
