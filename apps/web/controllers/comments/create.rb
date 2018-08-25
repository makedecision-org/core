module Web::Controllers::Comments
  class Create
    include Web::Action
    include Import[operation: 'proposals.operations.create_comment']

    def call(params)
      result = operation.call(**params)
      redirect_to routes.proposal_path(result.value!.proposal_id)
    end
  end
end
