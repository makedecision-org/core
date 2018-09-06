# frozen_string_literal: true

module Web::Views::Proposals
  class Index
    include Web::View

    def breadcrumb
      breadcrumb_generator(
        ['Dashboard', '/dashboard'],
        [params[:organisation_id], "/organisations/#{params[:organisation_id]}"],
        ['All Proposals']
      )
    end
  end
end
