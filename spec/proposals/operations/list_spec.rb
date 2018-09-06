# frozen_string_literal: true

RSpec.describe Proposals::Operations::List, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository) }
  let(:proposal_repository) { double(:proposal_repository, all: proposals) }

  subject { operation.call }

  context 'when repository returns list of proposals' do
    let(:proposals) { [Proposal.new] }

    it { expect(subject).to eq Success([Proposal.new]) }
  end

  context 'whith a real dependency' do
    let(:operation) { described_class.new }

    it { expect(subject).to eq Success([]) }
  end
end
