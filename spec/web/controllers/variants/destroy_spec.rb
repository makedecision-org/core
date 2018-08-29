RSpec.describe Web::Controllers::Variants::Destroy, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { id: 1 } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (id:) { Success(Variant.new(proposal_id: 1)) } }

    it { expect(subject).to redirect_to('/proposals/1') }
  end

  context 'when operation returns failure result' do
    let(:operation) { -> (id:) { Failure(Variant.new(proposal_id: 1)) } }

    it { expect(subject).to have_http_status(404) }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }
    let(:variant) { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id) }
    let(:params) { { id: variant.id } }

    it { expect(subject).to redirect_to("/proposals/#{proposal.id}") }
  end
end
