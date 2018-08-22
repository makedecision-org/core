RSpec.describe Web::Controllers::Proposals::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { {} }

  subject { action.call(params) }

  context 'when operation return success result' do
    let(:operation) { -> (*_) { Success(Proposal.new(id: 1)) } }

    it { expect(subject).to redirect_to('/proposals/1') }
  end

  context 'when operation return failure result' do
    let(:operation) { -> (*_) { Failure([]) } }

    it { expect(subject).to be_success 200 }
  end
end
