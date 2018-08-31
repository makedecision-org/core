RSpec.describe Organisations::Operations::List, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(org_repository: org_repository) }
  let(:org_repository) { double(:org_repository, all: orgs) }

  subject { operation.call }

  context 'when proposal exist' do
    let(:orgs) { [Organisation.new] }

    it { expect(subject).to eq Success(orgs) }
  end

  context 'when proposal not found' do
    let(:orgs) { [] }

    it { expect(subject).to eq Success([]) }
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }

    before { OrganisationRepository.new.create(slug: 'test-title', title: 'test', descriprion: 'test') }

    subject { operation.call }

    it { expect(subject).to be_success }
    it { expect(subject.value!.count).to eq 1 }
  end
end
