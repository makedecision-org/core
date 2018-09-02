RSpec.describe Organisations::Operations::CreateTeam, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(team_repository: team_repository) }
  let(:team_repository) { double(:team_repository, create: team) }

  subject { operation.call(title: 'test title', body: 'something here', organisation_id: 1) }

  context 'when proposal exist' do
    let(:team) { Team.new }

    it 'creates a new organisation' do
      expect(team_repository).to receive(:create).with(
        title: 'test title', body: 'something here', organisation_id: 1
      ).and_return(team)
      expect(subject).to eq Success(team)
    end
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:organisation) { OrganisationRepository.new.create(title: 'test', description: 'test', slug: 'test') }

    subject { operation.call(title: 'test title', body: 'something here', organisation_id: organisation.id) }

    it { expect(subject).to be_success }
  end
end
