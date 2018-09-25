# frozen_string_literal: true

module Web::Controllers::Home
  class Index
    include Web::Action

    def call(params); end

    private

    def authenticate!
      true
    end
  end
end
