module Web::Controllers::Organisations
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'organisations.operations.read']

    expose :organisation

    def call(params)
      case result = operation.call(slug: params[:slug])
      when Success
        @organisation = result.value!
      when Failure
        redirect_to routes.dashboard_path
      end
    end
  end
end
