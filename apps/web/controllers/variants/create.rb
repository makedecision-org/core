module Web::Controllers::Variants
  class Create
    include Web::Action
    include Import[operation: 'variants.operations.create']

    def call(params)
      operation.call(**params.to_h.slice(:proposal_id, :name, :body))
      redirect_to routes.organisation_proposal_path(params[:organisation_id], params[:proposal_id])
    end
  end
end
