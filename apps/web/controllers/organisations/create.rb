# frozen_string_literal: true

module Web::Controllers::Organisations
  class Create
    include Web::Action

    def call(_params)
      redirect_to routes.dashboard_path
    end
  end
end
