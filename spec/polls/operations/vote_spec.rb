# frozen_string_literal: true

RSpec.describe Polls::Operations::Vote, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(vote_repo: vote_repo, vote_choice_repo: vote_choice_repo) }
  let(:vote_repo) { double(:vote_repo, create: Vote.new(id: 321)) }
  let(:vote_choice_repo) { double(:vote_choice_repo, create: VoteChoice.new) }

  subject { operation.call(payload) }

  context 'when data is valid' do
    let(:payload) { { account_id: 1, poll_id: 123, reason: 'test', variant_ids: [21, '32', 43] } }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Vote) }

    it 'creates account vote object' do
      expect(vote_repo).to receive(:create).with(
        poll_id: 123, raw_reason: 'test', reason: 'test', account_id: 1
      ).and_return(Vote.new)

      subject
    end

    it 'creates account vote choice objects for each poll variant' do
      expect(vote_choice_repo).to receive(:create).with(vote_id: 321, poll_variant_id: 21)
      expect(vote_choice_repo).to receive(:create).with(vote_id: 321, poll_variant_id: 32)
      expect(vote_choice_repo).to receive(:create).with(vote_id: 321, poll_variant_id: 43)

      subject
    end

    context 'and reason is empty' do
      let(:payload) { { account_id: 1, poll_id: 123, reason: nil, variant_ids: [21, '32', 43] } }

      it { expect(subject).to be_success }
      it { expect(subject.value!).to be_a(Vote) }
    end
  end

  context 'when payload is invalid' do
    it 'returns error result' do
      [
        { poll_id: 123, reason: 'test', variant_ids: [21, 32, 43] },
        { account_id: 1, poll_id: 123, reason: 'test', variant_ids: [] },
        { account_id: 1, reason: 'test', variant_ids: [21, 32, 43] }
      ].each { |payload| expect(operation.call(payload)).to be_failure }
    end
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:account) { Fabricate.create(:account) }
    let(:poll) { Fabricate.create(:poll) }
    let(:poll_variant) { Fabricate.create(:poll_variant) }
    let(:payload) { { account_id: account.id, poll_id: poll.id, reason: 'test', variant_ids: [poll_variant.id] } }

    it { expect(subject).to be_success }
  end
end
