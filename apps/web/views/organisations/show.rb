# frozen_string_literal: true

module Web::Views::Organisations
  class Show
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [organisation.title]
      )
    end

    def sidebar_actions
      html do
        li { link_to 'Add new', '#' }
        div(class: 'dropdown-divider')

        li { link_to 'Proposal', routes.new_organisation_proposal_path(organisation.slug) }
        li { link_to 'Team', routes.new_organisation_team_path(organisation.slug) }
        li { link_to 'Members', '#' }
        div(class: 'dropdown-divider')
      end
    end
  end
end
