module Variants
  module Operations
    class Create < Libs::Operation
      include Import[
        'libs.markdown_parser',
        variant_repository: 'repositories.variant'
      ]

      def call(name:, proposal_id:, body: '')
        raw_body = body
        body = markdown_parser.call(raw_body) unless body.empty?

        # TODO: check name on not empty string and proposal_id on exist
        variant = variant_repository.create(
          name: name, proposal_id: proposal_id, body: body, raw_body: raw_body
        )

        Success(variant)
      end
    end
  end
end
