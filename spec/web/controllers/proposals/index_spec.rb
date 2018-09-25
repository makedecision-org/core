# frozen_string_literal: true

RSpec.describe Web::Controllers::Proposals::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { 'rack.session' => session } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns success result' do
    let(:operation) { -> { Success([Proposal.new]) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.proposals).to eq([Proposal.new])
    end
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success 200 }
  end
end
