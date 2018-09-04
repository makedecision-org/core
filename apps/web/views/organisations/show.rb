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
        li { link_to 'Add members', '#' }
        li { link_to 'Create team', '#' }
      end
    end
  end
end
