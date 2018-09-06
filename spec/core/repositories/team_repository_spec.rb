# frozen_string_literal: true

RSpec.describe TeamRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_organisation' do
    subject { repo.all_for_organisation(org_slug) }

    context 'when organisation with slug contain teams' do
      let(:organisation) { Fabricate.create(:organisation, slug: 'test') }
      let(:org_slug) { organisation.slug }

      before do
        other_organisation = Fabricate.create(:organisation, slug: 'other-test')
        Fabricate.create(:team, organisation_id: other_organisation.id)

        Fabricate.create(:team, organisation_id: organisation.id)
      end

      it { expect(subject.map(&:organisation_id)).to eq [organisation.id] }
    end

    context 'when organisation with slug not contain teams' do
      let(:organisation) { Fabricate.create(:organisation, slug: 'test') }
      let(:org_slug) { organisation.slug }

      before do
        other_organisation = Fabricate.create(:organisation, slug: 'other-test')
        Fabricate.create(:team, organisation_id: other_organisation.id)
      end

      it { expect(subject).to eq [] }
    end

    context 'when organisation not exist' do
      let(:org_slug) { 'not-exist' }

      it { expect(subject).to eq [] }
    end
  end
end
