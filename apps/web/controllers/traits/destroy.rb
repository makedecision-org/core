module Web::Controllers::Traits
  class Destroy
    include Web::Action
    include Import[operation: 'variants.operations.delete_trait']

    def call(params)
      result = operation.call(**params.to_h.slice(:variant_id, :value, :trait_type))
      redirect_to routes.organisation_proposal_path(params[:organisation_id], result.value!.proposal_id)
    end
  end
end
