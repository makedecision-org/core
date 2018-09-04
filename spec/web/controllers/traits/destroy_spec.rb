RSpec.describe Web::Controllers::Traits::Destroy, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { organisation_id: 'test', variant_id: 1, value: 'new trait', trait_type: 'positive' } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (variant_id:, trait_type:, value:) { Success(Variant.new(proposal_id: 1)) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'with real dependencies' do
    let(:action) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }
    let(:variant) { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id, positive_traits: [{ value: 'posititve trait' }]) }
    let(:params) { { organisation_id: 'test', variant_id: variant.id, trait_type: 'positive', value: 'posititve trait' } }

    it { expect(subject).to redirect_to("/organisations/test/proposals/#{proposal.id}") }
  end
end
