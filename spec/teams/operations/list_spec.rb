# frozen_string_literal: true

RSpec.describe Teams::Operations::List, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(team_repository: team_repository) }
  let(:team_repository) { double(:team_repository, all_for_organisation: teams) }

  subject { operation.call(org_slug: 'test') }

  context 'when proposals exist' do
    let(:teams) { [Team.new] }

    it { expect(subject).to eq Success(teams) }
  end

  context 'when proposals not found' do
    let(:teams) { [] }

    it { expect(subject).to eq Success([]) }
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:organisation) { Fabricate.create(:organisation, slug: 'test') }

    let(:team) { Fabricate.create(:team, organisation_id: organisation.id) }
    before { team }

    subject { operation.call(org_slug: organisation.slug) }

    it { expect(subject).to eq Success([team]) }
  end
end
