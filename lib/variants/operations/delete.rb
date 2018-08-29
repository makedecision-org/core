module Variants
  module Operations
    class Delete < Libs::Operation
      include Import[variant_repository: 'repositories.variant']

      def call(id:)
        variant = variant_repository.delete(id)
        variant ? Success(variant) : Failure(:not_exist)
      end
    end
  end
end
