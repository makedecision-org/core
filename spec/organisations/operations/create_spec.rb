RSpec.describe Organisations::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(org_repository: org_repository) }
  let(:org_repository) { double(:org_repository, create: org) }

  subject { operation.call(slug: 'test-title', title: 'test title', description: 'something here') }

  context 'when proposal exist' do
    let(:org) { Organisation.new }

    it 'creates a new organisation' do
      expect(org_repository).to receive(:create).with(
        description: 'something here', title: 'test title', slug: 'test-title'
      ).and_return(org)
      expect(subject).to eq Success(org)
    end
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
