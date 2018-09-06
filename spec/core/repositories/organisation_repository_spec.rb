# frozen_string_literal: true

RSpec.describe OrganisationRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_by_slug' do
    subject { repo.find_by_slug(organisation.slug) }

    context 'when organisation exist' do
      let(:organisation) { repo.create(title: 'test', description: 'something', slug: 'test') }

      it { expect(subject).to eq(organisation) }
    end

    context 'when organisation does not exist' do
      let(:organisation) { Organisation.new(title: 'test', description: 'something', slug: 'test') }

      it { expect(subject).to eq(nil) }
    end
  end
end
