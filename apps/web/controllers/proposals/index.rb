# frozen_string_literal: true

module Web::Controllers::Proposals
  class Index
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'proposals.operations.list']

    expose :proposals

    def call(_params)
      case result = operation.call
      when Success
        @proposals = result.value!
      end
    end
  end
end
