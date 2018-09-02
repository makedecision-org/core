RSpec.describe Variants::Operations::Delete, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(variant_repository: variant_repository) }
  let(:variant_repository) { double(:variant_repository, delete: Variant.new) }
  subject { operation.call(id: 1) }

  context 'when variant exist' do
    let(:variant_repository) { double(:variant_repository, delete: Variant.new) }

    it { expect(subject).to eq Success(Variant.new) }
  end

  context 'when variant not exist' do
    let(:variant_repository) { double(:variant_repository, delete: nil) }

    it { expect(subject).to eq Failure(:not_exist) }
  end

  context 'whis real dependencies' do
    let(:operation) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }
    let(:variant) { VariantRepository.new.create(name: 'test', proposal_id: proposal.id) }

    subject { operation.call(id: variant.id) }

    it { expect(subject).to eq Success(variant) }
  end
end
