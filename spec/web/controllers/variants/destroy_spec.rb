# frozen_string_literal: true

RSpec.describe Web::Controllers::Variants::Destroy, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) do
    { 'rack.session' => session, organisation_id: 'test', proposal_id: 1, name: 'test variant', body: '' }
  end
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns success result' do
    let(:operation) { ->(id:) { Success(Variant.new(proposal_id: 1)) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(id:) { Failure(Variant.new(proposal_id: 1)) } }

    it { expect(subject).to have_http_status(404) }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }
    let(:variant) { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id) }
    let(:params) { { 'rack.session' => session, organisation_id: 'test', id: variant.id } }

    it { expect(subject).to redirect_to("/organisations/test/proposals/#{proposal.id}") }
  end
end
