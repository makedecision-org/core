module Web::Controllers::Organisations
  class Create
    include Web::Action

    def call(params)
      redirect_to routes.dashboard_path
    end
  end
end
