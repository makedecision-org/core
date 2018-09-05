module Web::Views::Proposals
  class Show
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [params[:organisation_id], routes.organisation_path(params[:organisation_id])],
        [proposal.team.title, routes.organisation_team_path(params[:organisation_id], proposal.team.id)],
        [proposal.title]
      )
    end

    def sidebar_actions
      html do
        li { link_to 'Add new', '#' }
        div(class: 'dropdown-divider')

        li { link_to 'Proposal', routes.new_organisation_proposal_path(params[:organisation_id]) }
        li { link_to 'Members', '#' }
        li { link_to 'Team', '#' }
        div(class: 'dropdown-divider')
      end
    end

    def proposal_body
      raw_body(proposal.body)
    end

    def comment_body(comment)
      raw_body(comment.body)
    end

    def variant_body(variant)
      raw_body(variant.body)
    end

    def add_variant_form(options = {})
      form_for :variant, routes.variants_path(organisation_id: options[:org_id]), { method: :post } do
        input(name: 'proposal_id', type: 'hidden', value: proposal.id)
        input(name: 'name', type: 'text', placeholder: 'New Variant', class: 'form-control')
        textarea(name: 'body', placeholder: 'Description', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end

    def add_positive_trait_form(variant, options = {})
      form_for :trait, routes.traits_path(organisation_id: options[:org_id]), { method: :post, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'positive')
        input(name: 'value', type: 'text', placeholder: 'Positive trait', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end

    def add_negative_trait_form(variant, options = {})
      form_for :trait, routes.traits_path(organisation_id: options[:org_id]), { method: :post, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'negative')
        input(name: 'value', type: 'text', placeholder: 'Negative trait', class: 'form-control')
        submit 'Add', class: 'btn btn-primary'
      end
    end

    def delete_positive_trait_form(proposal, variant, trait_text, options = {})
      return trait_text unless proposal.open?

      form_for :trait, routes.trait_path(organisation_id: options[:org_id]), { method: :delete, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'positive')
        input(name: 'value', type: 'hidden', value: trait_text)
        text(trait_text)
        submit 'Delete', class: 'btn btn-danger'
      end
    end

    def delete_negative_trait_form(proposal, variant, trait_text, options = {})
      return trait_text unless proposal.open?

      form_for :trait, routes.trait_path(organisation_id: options[:org_id]), { method: :delete, class: 'form-inline' } do
        input(name: 'variant_id', type: 'hidden', value: variant.id)
        input(name: 'trait_type', type: 'hidden', value: 'negative')
        input(name: 'value', type: 'hidden', value: trait_text)
        text(trait_text)
        submit 'Delete', class: 'btn btn-danger'
      end
    end

    def update_proposal_status_form(options = {})
      form_for :trait, routes.proposal_status_path(proposal.id, organisation_id: options[:org_id]), { method: :patch } do
        textarea(name: "conclusions", placeholder: "Conclusions", class: "form-control")
        br
        button(type: "submit", value: "denied", name: "status", class: "btn btn-danger") { 'Deny' }
        button(type: "submit", value: "approved", name: "status", class: "btn btn-success") { 'Approve' }
      end
    end

    def add_comment_form(options = {})
      form_for :comment, routes.comments_path(organisation_id: options[:org_id]), { method: :post } do
        input(name: 'proposal_id', type: 'hidden', value: proposal.id)
        textarea(name: "body", placeholder: "New comment", class: "form-control")
        br
        submit 'Add', class: 'btn btn-primary'
      end
    end

  private

    def raw_body(body)
      raw(body || '')
    end
  end
end
