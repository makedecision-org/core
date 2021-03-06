# frozen_string_literal: true

RSpec.describe Proposals::Operations::Read, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository) }
  let(:proposal_repository) { double(:proposal_repository, find_with_variants: proposal) }

  subject { operation.call(id: 1) }

  context 'when proposal exist' do
    let(:proposal) { Proposal.new }

    it { expect(subject).to eq Success(proposal) }
  end

  context 'when proposal not found' do
    let(:proposal) { nil }

    it { expect(subject).to eq Failure(:not_found) }
  end

  context 'whith real dependencies' do
    let(:proposal) { Fabricate.create(:proposal) }

    subject { operation.call(id: proposal.id) }

    it { expect(subject).to eq Success(proposal) }
  end
end
