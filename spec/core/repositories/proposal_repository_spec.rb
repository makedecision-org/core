# frozen_string_literal: true

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

  describe '#grupped_by_status_for_team' do
    let(:team) { Fabricate.create(:team) }

    subject { repo.grupped_by_status_for_team(team.id) }

    context 'when team has some proposals' do
      before do
        Fabricate.create(:proposal, team_id: team.id, status: 'open')
        Fabricate.create(:proposal, team_id: team.id, status: 'approved')

        Fabricate.create(:proposal, status: 'approved')
      end

      it { expect(subject.keys).to eq %w[open approved] }
      it { expect(subject['open'].count).to eq 1 }
      it { expect(subject['approved'].count).to eq 1 }
    end

    context 'when team does not have proposals' do
      before { Fabricate.create(:proposal, status: 'approved') }

      it { expect(subject).to eq({}) }
    end

    context 'when team does not exist' do
      subject { repo.grupped_by_status_for_team(0) }

      it { expect(subject).to eq({}) }
    end
  end
end
