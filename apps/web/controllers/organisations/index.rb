module Web::Controllers::Organisations
  class Index
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'organisations.operations.list']

    expose :organisations

    def call(_params)
      case result = operation.call
      when Success
        @organisations = result.value!
      end
    end
  end
end
