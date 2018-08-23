RSpec.describe Proposals::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository) }
  let(:proposal_repository) { double(:proposal_repository, create: Proposal.new) }

  subject { operation.call(title: 'test', body: 'test') }

  it { expect(subject).to eq Success(Proposal.new) }

  context 'whith real dependencies' do
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect{ subject }.to change { ProposalRepository.new.all.count }.by(1) }
  end
end
