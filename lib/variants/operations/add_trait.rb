module Variants
  module Operations
    class AddTrait < Libs::Operation
      include Import[variant_repository: 'repositories.variant']

      def call(variant_id:, value:, trait_type:)
        # TODO: valodation

        variant = case trait_type.to_sym
        when :positive
          variant_repository.add_positive_trait(variant_id, value)
        when :negative
          variant_repository.add_negative_trait(variant_id, value)
        else
          fail
        end

        Success(variant)
      end
    end
  end
end
