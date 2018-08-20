module Web::Views::Proposals
  class Show
    include Web::View

    def add_variant_form
      form_for :variant, routes.variants_path, { method: :post } do
        input(name: 'proposal_id', type: 'hidden', value: proposal.id)
        input(name: 'name', type: 'text', placeholder: 'New Variant', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end
  end
end
