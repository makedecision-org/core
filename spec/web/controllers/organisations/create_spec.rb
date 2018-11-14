# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    it { expect(subject).to redirect_to('/dashboard') }
  end

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
