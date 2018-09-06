# frozen_string_literal: true

RSpec.describe Teams::Operations::ProposalsList, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository) }
  let(:proposal_repository) { double(:proposal_repository, grupped_by_status_for_team: proposals) }

  subject { operation.call(team_id: 1) }

  context 'when proposals exist' do
    let(:proposals) { { 'open' => [Team.new] } }

    it { expect(subject).to eq Success(proposals) }
  end

  context 'when proposals not found' do
    let(:proposals) { {} }

    it { expect(subject).to eq Success({}) }
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }

    subject { operation.call(team_id: proposal.team_id) }

    it { expect(subject).to be_success }
  end
end
