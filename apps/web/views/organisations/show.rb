module Web::Views::Organisations
  class Show
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [organisation.title]
      )
    end
  end
end
