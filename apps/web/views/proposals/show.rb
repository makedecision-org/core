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

    def add_positive_trait_form(variant)
      form_for :trait, routes.traits_path, { method: :post, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'positive')
        input(name: 'value', type: 'text', placeholder: 'Positive trait', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end

    def add_negative_trait_form(variant)
      form_for :trait, routes.traits_path, { method: :post, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'negative')
        input(name: 'value', type: 'text', placeholder: 'Negative trait', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end
  end
end
