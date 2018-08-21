RSpec.describe Web::Controllers::ProposalStatuses::Update, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { id: 1, status: :test } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (id:, **_) { Success(id) } }

    it { expect(subject).to redirect_to('/proposals/1') }
  end

  xcontext 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }
    let(:params) { { proposal_id: proposal.id, name: 'test variant' } }

    it { expect { subject }.to change { VariantRepository.new.all.count }.by(1) }
    it { expect(subject).to redirect_to("/proposals/#{proposal.id}") }
  end
end
