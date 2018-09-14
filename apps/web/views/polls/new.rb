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

    def form
      form_for :poll, routes.organisation_proposal_polls_path(params[:organisation_id], proposal.id), method: :post do
        div(class: 'form-group') do
          label :title
          text_field :title, class: 'form-control', placeholder: 'What is the topic you want to poll?'
        end

        submit 'Suggest', class: 'btn btn-primary'
      end
    end
  end
end
