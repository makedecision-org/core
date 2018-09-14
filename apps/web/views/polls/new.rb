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
  end
end
