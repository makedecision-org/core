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
        li { link_to 'Add members', '#' }
        li { link_to 'Create team', '#' }
      end
    end

    def form
      form_for :proposal, routes.organisation_proposals_path(params[:organisation_id]), { method: :post } do
        div(class: 'proposal-form__path') do
          div(class: 'form-group proposal-form__item') do
            label :team
            values = { 'Team #1' => '1', 'Team #2' => '2' }
            select :team_id, values, class: 'form-control'
          end

          span '/', class: 'proposal-form__path-delimeter'

          div(class: 'form-group proposal-form__item') do
            label :title
            text_field :title, class: 'form-control'
          end
        end

        div(class: 'form-group') do
          label :body
          text_area :body, class: 'form-control', placeholder: 'Description'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
