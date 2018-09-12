# frozen_string_literal: true

module Web::Views::Proposals
  class New
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [params[:organisation_id], "/organisations/#{params[:organisation_id]}"],
        ['New Proposal']
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
      form_for :proposal, routes.organisation_proposals_path(params[:organisation_id]), method: :post do
        div(class: 'proposal-form__path') do
          div(class: 'form-group proposal-form__item') do
            label :team
            values = teams.map { |team| [team.title, team.id] }.to_h
            select :team_id, values, class: 'form-control'
          end

          span '/', class: 'proposal-form__path-delimeter'

          div(class: 'form-group proposal-form__item proposal-form__title') do
            label :title
            text_field :title, class: 'form-control', placeholder: 'What is the topic you want to discuss?'
          end
        end

        div(class: 'form-group') do
          label :body
          text_area :body, class: 'form-control',
                           placeholder: 'Give enough background information for the team and organisation to have a productive discussion. This can be updated as the discussion progresses'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
