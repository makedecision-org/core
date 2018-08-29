module Web::Controllers::Traits
  class Destroy
    include Web::Action
    include Import[operation: 'variants.operations.delete_trait']

    def call(params)
      result = operation.call(**params)
      redirect_to routes.proposal_path(result.value!.proposal_id)
    end
  end
end
