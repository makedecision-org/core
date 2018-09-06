# frozen_string_literal: true

module Web::Views::Teams
  class New
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [params[:organisation_id], "/organisations/#{params[:organisation_id]}"],
        ['New Team']
      )
    end

    def sidebar_actions
      html do
        li { link_to 'Add new', '#' }
        div(class: 'dropdown-divider')

        li { link_to 'Proposal', routes.new_organisation_proposal_path(params[:organisation_id]) }
        li { link_to 'Team', routes.new_organisation_team_path(params[:organisation_id]) }
        li { link_to 'Members', '#' }
        div(class: 'dropdown-divider')
      end
    end

    def form
      form_for :team, routes.organisation_teams_path(params[:organisation_id]), method: :post do
        text_field :organisation_id, type: 'hidden', value: organisation.id

        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control'
        end

        div(class: 'form-group') do
          label :body
          text_area :body, class: 'form-control', placeholder: 'Description'
        end

        submit 'Create', class: 'btn btn-primary'
      end
    end
  end
end
