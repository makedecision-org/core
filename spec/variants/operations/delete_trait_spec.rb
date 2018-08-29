RSpec.describe Variants::Operations::DeleteTrait, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(variant_repository: variant_repository) }
  let(:variant_repository) do
    double(:variant_repository, delete_positive_trait: variant, delete_negative_trait: variant)
  end

  let(:variant) { Variant.new(proposal_id: 123) }

  subject { operation.call(variant_id: 1, value: 'new trait', trait_type: type) }

  context 'when trait type is positive' do
    let(:type) { :positive }

    it 'updates variant traits' do
      expect(variant_repository).to receive(:delete_positive_trait).with(1, 'new trait')
      expect(subject).to eq Success(variant)
    end

    context 'and type is string type' do
      let(:type) { 'positive' }

      it 'updates variant traits' do
        expect(variant_repository).to receive(:delete_positive_trait).with(1, 'new trait')
        expect(subject).to eq Success(variant)
      end
    end
  end

  context 'when trait type is negative' do
    let(:type) { :negative }

    it 'updates variant traits' do
      expect(variant_repository).to receive(:delete_negative_trait).with(1, 'new trait')
      expect(subject).to eq Success(variant)
    end

    context 'and type is string type' do
      let(:type) { 'negative' }

      it 'updates variant traits' do
        expect(variant_repository).to receive(:delete_negative_trait).with(1, 'new trait')
        expect(subject).to eq Success(variant)
      end
    end
  end

  context 'when trait type invalid' do
    let(:type) { :invalid }

    it { expect { subject }.to raise_error }
  end

  xcontext 'with a real dependency' do
    it 'updates traits for the variant' do
    end
  end
end
