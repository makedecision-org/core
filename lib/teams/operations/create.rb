module Teams
  module Operations
    class Create < Libs::Operation
      include Import[
        'libs.markdown_parser',
        team_repository: 'repositories.team'
      ]

      def call(organisation_id:, title:, body:)
        raw_body = body
        body = markdown_parser.call(raw_body)

        Success(
          team_repository.create(
            title: title,
            organisation_id: organisation_id,
            raw_body: raw_body,
            body: body
          )
        )
      end
    end
  end
end

