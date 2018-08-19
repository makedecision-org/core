RSpec.describe Variants::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(variant_repository: variant_repository) }
  let(:variant_repository) { double(:variant_repository, create: Variant.new) }

  subject { operation.call(proposal_id: 1, name: 'new variant here') }

  context 'when data valid' do
    it 'creates a new variant for the proposal' do
      expect(variant_repository).to receive(:create).with(name: 'new variant here', proposal_id: 1)
      expect(subject).to be_success
    end
  end

  context 'whis real dependencies' do
    let(:operation) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }

    subject { operation.call(proposal_id: proposal.id, name: 'new variant here') }

    it { expect(subject).to be_success }
  end
end
