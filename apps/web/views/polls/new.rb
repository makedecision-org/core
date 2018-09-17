# frozen_string_literal: true

module Web::Views::Polls
  class New
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [params[:organisation_id], routes.organisation_path(params[:organisation_id])],
        [proposal.team.title, routes.organisation_team_path(params[:organisation_id], proposal.team.id)],
        [proposal.title, routes.organisation_proposal_path(params[:organisation_id], proposal.id)],
        ['New Poll']
      )
    end

    def choice_form
      form_for :poll, routes.organisation_proposal_polls_path(params[:organisation_id], proposal.id), method: :post do
        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'What is the topic you want to poll?'
        end

        div(class: 'form-group new-poll__variants') do
          label :variants
          text_field :variants, class: 'form-control', value: 'Something'
        end

        div(class: 'form-group') do
          button 'Add more', type: :button, class: 'btn btn-outline-primary', id: 'add-poll-variant'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end

    def agreement_form
      form_for :poll, routes.organisation_proposal_polls_path(params[:organisation_id], proposal.id), method: :post do
        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'What is the topic you want to poll?'
        end

        div(class: 'form-group') do
          label :variants
          text_field :title, readonly: '', class: 'form-control', value: 'Agree'
          text_field :title, readonly: '', class: 'form-control', value: 'Disagree'
          text_field :title, readonly: '', class: 'form-control', value: 'Block'
          text_field :title, readonly: '', class: 'form-control', value: 'Abstain'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
