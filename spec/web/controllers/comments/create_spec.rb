RSpec.describe Web::Controllers::Comments::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { proposal_id: 1, body: 'new comment' } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (proposal_id:, body:) { Success(Comment.new(proposal_id: 1)) } }

    it { expect(subject).to redirect_to('/proposals/1') }
  end

  xcontext 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }
    let(:variant) { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id) }
    let(:params) { { variant_id: variant.id, trait_type: 'positive', value: 'new posititve trait' } }

    it { expect(subject).to redirect_to("/proposals/#{proposal.id}") }
  end
end
