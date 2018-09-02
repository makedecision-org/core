RSpec.describe Organisations::Operations::Read, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(org_repository: org_repository) }
  let(:org_repository) { double(:org_repository, find_by_slug: org) }

  subject { operation.call(slug: 1) }

  context 'when proposal exist' do
    let(:org) { Organisation.new }

    it { expect(subject).to eq Success(org) }
  end

  context 'when proposal not found' do
    let(:org) { nil }

    it { expect(subject).to eq Failure(:not_found) }
  end

  context 'whith real dependencies' do
    let(:org) { Fabricate.create(:organisation) }

    subject { operation.call(slug: org.slug) }

    it { expect(subject).to eq Success(org) }
  end
end
