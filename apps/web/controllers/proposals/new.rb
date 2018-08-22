module Web::Controllers::Proposals
  class New
    include Web::Action

    expose :proposal

    def call(params)
      @proposal = Proposal.new
    end
  end
end
