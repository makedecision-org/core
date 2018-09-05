RSpec.describe Teams::Operations::Read, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(team_repository: team_repository) }
  let(:team_repository) { double(:team_repository, find: team) }

  subject { operation.call(org_slug: 'test', id: 1) }

  context 'when proposal exist' do
    let(:team) { Team.new }

    it { expect(subject).to eq Success(team) }
  end

  context 'when proposal not found' do
    let(:team) { nil }

    it { expect(subject).to eq Failure(:not_found) }
  end

  context 'whith real dependencies' do
    let(:team) { Fabricate.create(:team) }

    subject { operation.call(org_slug: 'test', id: team.id) }

    it { expect(subject).to eq Success(team) }
  end
end
