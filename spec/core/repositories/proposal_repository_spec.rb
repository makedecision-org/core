RSpec.describe ProposalRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_with_variants' do
    let(:proposal) { Fabricate.create(:proposal) }

    subject { repo.find_with_variants(proposal.id) }

    context 'when proposal has variants' do
      before { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id) }

      it { expect(subject).to be_a(Proposal) }
      it { expect(subject.variants).to all(be_a(Variant)) }
      it { expect(subject.comments).to eq([]) }
    end

    context 'when proposal does not have variants' do
      it { expect(subject).to be_a(Proposal) }
      it { expect(subject.variants).to eq([]) }
      it { expect(subject.comments).to eq([]) }
    end

    context 'when proposal not exist in db' do
      subject { repo.find_with_variants(0) }

      it { expect(subject).to eq nil }
    end
  end
end
