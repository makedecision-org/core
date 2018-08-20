module Web::Controllers::Traits
  class Create
    include Web::Action
    include Import[operation: 'variants.operations.add_trait']

    def call(params)
      result = operation.call(**params)
      redirect_to routes.proposal_path(result.value!.proposal_id)
    end
  end
end
