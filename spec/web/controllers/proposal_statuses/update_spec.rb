RSpec.describe Web::Controllers::ProposalStatuses::Update, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:operation) { -> (_) { Success(1) } }
  let(:params) { { id: 1 } }

  subject { action.call(params) }

  it { expect(subject).to redirect_to('/proposals/1') }

  context 'with a real dependency' do
    let(:action) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }

    let(:params) { { id: proposal.id, status: 'approved' } }

    it 'updates proposal status' do
      expect(subject).to redirect_to("/proposals/#{proposal.id}")
      expect(ProposalRepository.new.find(proposal.id).status).to eq('approved')
    end
  end
end
