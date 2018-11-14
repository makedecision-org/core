# frozen_string_literal: true

RSpec.describe Polls::Operations::Read, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(poll_repo: poll_repo) }
  let(:poll_repo) { double(:poll_repo, find: Poll.new(id: 1)) }
  let(:poll_variant_repo) { double(:poll_variant_repo, create: PollVariant.new(id: 1)) }
  let(:id) { 1 }

  subject { operation.call(id: id) }

  context 'when poll is exist' do
    let(:poll_repo) { double(:poll_repo, find: Poll.new(id: 1)) }

    it { expect(subject).to eq Success(Poll.new(id: 1)) }
  end

  context 'when poll is not exist' do
    let(:poll_repo) { double(:poll_repo, find: nil) }

    it { expect(subject).to eq Failure(:not_found) }
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }

    let(:poll) { Fabricate.create(:poll) }
    let(:id) { poll.id }

    it { expect(subject).to be_success }
  end
end
