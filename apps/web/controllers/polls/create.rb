# frozen_string_literal: true

module Web::Controllers::Polls
  class Create
    include Web::Action

    def call(_params)
      self.body = 'OK'
    end
  end
end
