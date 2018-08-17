RSpec.describe Web::Controllers::Proposals::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { Hash[] }

  subject { action.call(params) }

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

    it 'returns list of proposals' do
      subject
      expect(action.proposals).to eq([])
    end
  end
end
