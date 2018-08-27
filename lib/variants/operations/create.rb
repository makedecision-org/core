module Variants
  module Operations
    class Create < Libs::Operation
      include Import[variant_repository: 'repositories.variant']

      def call(name:, proposal_id:, body: '')
        # TODO: check name on not empty string and proposal_id on exist
        variant = variant_repository.create(name: name, proposal_id: proposal_id, body: body)
        Success(variant)
      end
    end
  end
end
