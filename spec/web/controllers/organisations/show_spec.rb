# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session, id: 'test' } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { ->(slug:) { Success(Organisation.new) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.organisation).to eq(Organisation.new)
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(slug:) { Failure(:not_found) } }

    it { expect(subject).to redirect_to('/dashboard') }
  end

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    before { Fabricate.create(:organisation) }

    it { expect(subject).to be_success 200 }
  end
end
