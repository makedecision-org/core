module Web::Views::Proposals
  class Show
    include Web::View

    def proposal_body
      raw(proposal.body)
    end

    def comment_body(comment)
      raw(comment.body)
    end

    def variant_body(variant)
      raw(variant.body)
    end

    def add_variant_form
      form_for :variant, routes.variants_path, { method: :post } do
        input(name: 'proposal_id', type: 'hidden', value: proposal.id)
        input(name: 'name', type: 'text', placeholder: 'New Variant', class: 'form-control')
        textarea(name: 'body', placeholder: 'Description', class: 'form-control')
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

    def update_proposal_status_form
      form_for :trait, routes.proposal_status_path(proposal.id), { method: :patch } do
        textarea(name: "conclusions", placeholder: "Conclusions", class: "form-control")
        br
        button(type: "submit", value: "denied", name: "status", class: "btn btn-danger") { 'Deny' }
        button(type: "submit", value: "approved", name: "status", class: "btn btn-success") { 'Approve' }
      end
    end

    def add_comment_form
      form_for :comment, routes.comments_path, { method: :post } do
        input(name: 'proposal_id', type: 'hidden', value: proposal.id)
        textarea(name: "body", placeholder: "New comment", class: "form-control")
        br
        submit 'Add', class: 'btn btn-primary'
      end
    end
  end
end
