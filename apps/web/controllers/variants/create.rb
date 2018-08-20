module Web::Controllers::Variants
  class Create
    include Web::Action
    include Import[operation: 'variants.operations.create']

    def call(params)
      operation.call(**params)
      redirect_to routes.proposal_path(params[:proposal_id])
    end
  end
end
