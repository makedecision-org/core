RSpec.describe Web::Controllers::Proposals::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { Hash[] }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (id:) { Success(Proposal.new) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.proposal).to eq(Proposal.new)
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { -> (id:) { Failure(:not_found) } }

    it { expect(subject).to redirect_to('/proposals') }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success 200 }
  end
end
