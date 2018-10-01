# frozen_string_literal: true

RSpec.describe Web::Controllers::ProposalStatuses::Update, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, organisation_id: 'test', id: 1, status: :test } }
  let(:session) { { account: Account.new(id: 1) } }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { ->(id:, **_) { Success(id) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(id:, **_) { Failure(id) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }
    let(:params) do
      {
        'rack.session' => session,
        organisation_id: 'test',
        id: proposal.id,
        status: 'approved',
        conclusions: 'closed'
      }
    end

    it { expect(subject).to redirect_to("/organisations/test/proposals/#{proposal.id}") }
  end
end
