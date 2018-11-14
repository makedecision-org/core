# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
