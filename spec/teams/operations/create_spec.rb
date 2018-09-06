# frozen_string_literal: true

RSpec.describe Teams::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(team_repository: team_repository) }
  let(:team_repository) { double(:team_repository, create: Team.new) }

  subject { operation.call(title: 'test title', body: 'test **body**', organisation_id: 1) }

  it 'saves a new proposal' do
    expect(team_repository).to receive(:create).with(
      organisation_id: 1,
      body: "<p>test <strong>body</strong></p>\n",
      raw_body: 'test **body**',
      title: 'test title'
    ).and_return(Team.new)

    expect(subject).to eq Success(Team.new)
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:organisation) { Fabricate.create(:organisation, slug: 'test') }

    subject { operation.call(title: 'test title', body: 'test **body**', organisation_id: organisation.id) }

    it { expect(subject).to be_success }
    it { expect { subject }.to change { TeamRepository.new.all.count }.by(1) }
  end
end
