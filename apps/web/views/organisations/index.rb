module Web::Views::Organisations
  class Index
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard']
      )
    end
  end
end
