module Web::Controllers::Home
  class About
    include Web::Action

    def call(params); end

    private

    def authenticate!
      true
    end
  end
end
