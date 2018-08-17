RSpec.describe ProposalRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_with_variants' do
    let(:proposal) { repo.create(title: 'test', body: 'test case for new proposal') }

    subject { repo.find_with_variants(proposal.id) }

    context 'when proposal has variants' do
      before { VariantRepository.new.create(name: 'variant #1', proposal_id: proposal.id) }

      it { expect(subject).to be_a(Proposal) }
      it { expect(subject.variants).to all(be_a(Variant)) }
    end

    context 'when proposal does not have variants' do
      it { expect(subject).to be_a(Proposal) }
      it { expect(subject.variants).to eq([]) }
    end

    context 'when proposal not exist in db' do
      subject { repo.find_with_variants(0) }

      it { expect(subject).to eq nil }
    end
  end
end
