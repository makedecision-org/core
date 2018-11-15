# frozen_string_literal: true

RSpec.describe Web::Controllers::Votes::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) do
    { 'rack.session' => session, organisation_id: 'test', proposal_id: 1, pull_id: 1 }
  end
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success({}) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(nil) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }

    let(:session) { { account: account } }
    let(:account) { Fabricate.create(:account) }
    let(:poll) { Fabricate.create(:poll) }
    let(:poll_variant) { Fabricate.create(:poll_variant, poll_id: poll.id) }

    let(:params) do
      {
        'rack.session' => session,
        organisation_id: 'test',
        proposal_id: poll.proposal_id,
        poll_id: poll.id,
        reason: 'test reason',
        variant_ids: [poll_variant.id.to_s]
      }
    end

    it { expect(subject).to redirect_to("/organisations/test/proposals/#{poll.proposal_id}") }
  end
end
