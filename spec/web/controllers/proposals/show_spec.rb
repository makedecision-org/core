# frozen_string_literal: true

RSpec.describe Web::Controllers::Proposals::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, organisation_id: 'test', id: 1 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns success result' do
    let(:operation) { ->(id:) { Success(Proposal.new(id: id)) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.proposal).to eq(Proposal.new(id: 1))
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(id:) { Failure(:not_found) } }

    it { expect(subject).to redirect_to('/organisations/test') }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }

    let(:params) { { id: proposal.id } }

    it { expect(subject).to be_success 200 }
  end
end
