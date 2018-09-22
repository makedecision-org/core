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
        text_field :type, type: 'hidden', value: 'choice'
        text_field :proposal_id, type: 'hidden', value: params[:proposal_id]

        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'What is the topic you want to poll?'
        end

        div(class: 'form-group') do
          label :description
          text_area :description, class: 'form-control', placeholder: ''
        end

        div(class: 'form-group new-poll__variants') do
          label :poll_variants

          text_field :title, class: 'form-control', value: 'Something', name: 'poll[poll_variants][][title]'
        end

        div(class: 'form-group') do
          button 'Add more', type: :button, class: 'btn btn-outline-primary', id: 'add-poll-variant'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end

    def agreement_form
      form_for :poll, routes.organisation_proposal_polls_path(params[:organisation_id], proposal.id), method: :post do
        text_field :type, type: 'hidden', value: 'agreement'
        text_field :proposal_id, type: 'hidden', value: params[:proposal_id]

        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'What is the topic you want to poll?'
        end

        div(class: 'form-group') do
          label :description
          text_area :description, class: 'form-control', placeholder: ''
        end

        div(class: 'form-group') do
          label :variants

          text_field :title, readonly: '', class: 'form-control', value: 'Agree', name: 'poll[poll_variants][][title]'
          text_field :title, readonly: '', class: 'form-control', value: 'Disagree', name: 'poll[poll_variants][][title]'
          text_field :title, readonly: '', class: 'form-control', value: 'Block', name: 'poll[poll_variants][][title]'
          text_field :title, readonly: '', class: 'form-control', value: 'Abstain', name: 'poll[poll_variants][][title]'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
