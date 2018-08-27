RSpec.describe Web::Controllers::Variants::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { proposal_id: 1, name: 'test variant', body: '' } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (proposal_id:, name:, body:) { Success(Variant.new) } }

    it { expect(subject).to redirect_to('/proposals/1') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }
    let(:params) { { proposal_id: proposal.id, name: 'test variant', body: 'test' } }

    it { expect { subject }.to change { VariantRepository.new.all.count }.by(1) }
    it { expect(subject).to redirect_to("/proposals/#{proposal.id}") }
  end
end
