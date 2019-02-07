# frozen_string_literal: true

RSpec.describe VariantRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:proposal) { Fabricate.create(:proposal) }

  describe '#add_positive_trait' do
    subject { repo.add_positive_trait(variant.id, 'new positive trait') }

    context 'when variant contain positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id, positive_traits: [{ value: 'new one' }]) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).positive_traits).to eq([{ value: 'new one' }, { value: 'new positive trait' }])
      end
    end

    context 'when variant have no one positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).positive_traits).to eq([{ value: 'new positive trait' }])
      end
    end

    context 'when variant is not exist in db' do
      subject { repo.add_positive_trait(0, 'new positive trait') }

      it { expect { subject }.to raise_error }
    end
  end

  describe '#add_negative_trait' do
    subject { repo.add_negative_trait(variant.id, 'new positive trait') }

    context 'when variant contain positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id, negative_traits: [{ value: 'new one' }]) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).negative_traits).to eq([{ value: 'new one' }, { value: 'new positive trait' }])
      end
    end

    context 'when variant have no one positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).negative_traits).to eq([{ value: 'new positive trait' }])
      end
    end

    context 'when variant is not exist in db' do
      subject { repo.add_negative_trait(0, 'new positive trait') }

      it { expect { subject }.to raise_error }
    end
  end

  describe '#delete_positive_trait' do
    subject { repo.delete_positive_trait(variant.id, 'old positive trait') }

    context 'when variant contain positive traits' do
      let(:variant) do
        repo.create(
          name: 'test',
          proposal_id: proposal.id,
          positive_traits: [{ value: 'new one' }, { value: 'old positive trait' }]
        )
      end

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).positive_traits).to eq([{ value: 'new one' }])
      end
    end

    context 'when variant contain other traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id, positive_traits: [{ value: 'new one' }]) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).positive_traits).to eq([{ value: 'new one' }])
      end
    end

    context 'when variant have no one positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).positive_traits).to eq([])
      end
    end

    context 'when variant is not exist in db' do
      subject { repo.add_positive_trait(0, 'old positive trait') }

      it { expect { subject }.to raise_error }
    end
  end

  describe '#delete_negative_trait' do
    subject { repo.delete_negative_trait(variant.id, 'old positive trait') }

    context 'when variant contain negative trait' do
      let(:variant) do
        repo.create(
          name: 'test',
          proposal_id: proposal.id,
          negative_traits: [{ value: 'new one' }, { value: 'old positive trait' }]
        )
      end

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).negative_traits).to eq([{ value: 'new one' }])
      end
    end

    context 'when variant contain other traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id, negative_traits: [{ value: 'new one' }]) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).negative_traits).to eq([{ value: 'new one' }])
      end
    end

    context 'when variant have no one positive traits' do
      let(:variant) { repo.create(name: 'test', proposal_id: proposal.id) }

      it 'adds one more trait to the variant' do
        subject
        expect(repo.find(variant.id).negative_traits).to eq([])
      end
    end

    context 'when variant is not exist in db' do
      subject { repo.add_negative_trait(0, 'old positive trait') }

      it { expect { subject }.to raise_error }
    end
  end
end
