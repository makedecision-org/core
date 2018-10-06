# frozen_string_literal: true

module Web::Controllers::Votes
  class Create
    include Web::Action

    def call(_params)
      self.body = 'OK'
    end
  end
end
