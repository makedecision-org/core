# frozen_string_literal: true

RSpec.describe Polls::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(poll_repo: poll_repo, poll_variant_repo: poll_variant_repo) }
  let(:poll_repo) { double(:poll_repo, create: Poll.new(id: 1)) }
  let(:poll_variant_repo) { double(:poll_variant_repo, create: PollVariant.new(id: 1)) }
  let(:payload) { {} }

  subject { operation.call(payload: payload) }

  context 'when poll payload is valid' do
    let(:payload) do
      {
        proposal_id: 11,
        title: 'test poll',
        description: 'something here',
        type: 'check',
        variants: [
          { title: 'variant #1' },
          { title: 'variant #2', prioroty: 2 },
          { title: 'variant #3', prioroty: 10 }
        ]
      }
    end

    it { expect(subject).to eq Success(Poll.new(id: 1)) }

    it 'persist poll data' do
      expect(poll_repo).to receive(:create).with(
        proposal_id: 11, type: 'check', title: 'test poll', description: 'something here'
      ).and_return(Poll.new(id: 1))

      expect(subject).to be_success
    end

    it 'persist poll variant data' do
      expect(poll_variant_repo).to receive(:create).exactly(1).times.with(poll_id: 1, title: 'variant #1', prioroty: 1)
      expect(poll_variant_repo).to receive(:create).exactly(1).times.with(poll_id: 1, title: 'variant #2', prioroty: 2)
      expect(poll_variant_repo).to receive(:create).exactly(1).times.with(poll_id: 1, title: 'variant #3', prioroty: 10)

      expect(subject).to be_success
    end
  end

  context 'when poll payload is invalid' do
    let(:payload) do
      {
        description: 'something here',
        variants: [
          { title: 'variant #1' },
          { title: 'variant #2' },
          { title: 'variant #3' }
        ]
      }
    end

    it { expect(subject).to be_failure }
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }

    let(:proposal) { Fabricate.create(:proposal) }
    let(:payload) do
      {
        proposal_id: proposal.id,
        type: 'check',
        title: 'test poll',
        description: 'something here',
        variants: [
          { title: 'variant #1' },
          { title: 'variant #2', prioroty: 2 },
          { title: 'variant #3', prioroty: 10 }
        ]
      }
    end

    it { expect(subject).to be_success }
  end
end
