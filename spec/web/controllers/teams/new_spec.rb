# frozen_string_literal: true

RSpec.describe Web::Controllers::Teams::New, type: :action do
  let(:action) { described_class.new(org_operation: operation) }
  let(:params) { { 'rack.session' => session, organisation_id: 'test' } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns success result' do
    let(:operation) { ->(slug:) { Success(Organisation.new(title: 'test')) } }

    it { expect(subject).to be_success }

    it do
      action.call(params)
      expect(action.organisation).to eq Organisation.new(title: 'test')
      expect(action.team).to eq Team.new
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(slug:) { Failure(:not_found) } }

    it { expect(subject).to be_success }

    it do
      action.call(params)
      expect(action.organisation).to eq Organisation.new
      expect(action.team).to eq Team.new
    end
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success 200 }
  end
end
