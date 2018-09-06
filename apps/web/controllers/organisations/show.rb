# frozen_string_literal: true

module Web::Controllers::Organisations
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'organisations.operations.read']

    expose :organisation

    def call(params)
      case result = operation.call(slug: params[:id])
      when Success
        @organisation = result.value!
      when Failure
        redirect_to routes.dashboard_path
      end
    end
  end
end
