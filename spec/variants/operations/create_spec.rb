RSpec.describe Variants::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(variant_repository: variant_repository) }
  let(:variant_repository) { double(:variant_repository, create: Variant.new) }

  context 'when data valid' do
    context 'and body is exist' do
      subject { operation.call(proposal_id: 1, name: 'new variant here', body: '**variant** body') }

      it 'creates a new variant for the proposal' do
        expect(variant_repository).to receive(:create).with(
          name: 'new variant here', proposal_id: 1, raw_body: '**variant** body', body: "<p><strong>variant</strong> body</p>\n"
        )
        expect(subject).to be_success
      end
    end

    context 'and body is empty' do
      subject { operation.call(proposal_id: 1, name: 'new variant here') }

      it 'creates a new variant for the proposal' do
        expect(variant_repository).to receive(:create).with(name: 'new variant here', proposal_id: 1, body: '', raw_body: '')
        expect(subject).to be_success
      end
    end
  end

  context 'whis real dependencies' do
    let(:operation) { described_class.new }
    let(:proposal) { ProposalRepository.new.create(title: 'test', body: 'test') }

    subject { operation.call(proposal_id: proposal.id, name: 'new variant here') }

    it { expect(subject).to be_success }
  end
end
