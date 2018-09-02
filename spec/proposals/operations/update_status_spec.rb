RSpec.describe Proposals::Operations::UpdateStatus, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository) }
  let(:proposal_repository) { double(:proposal_repository, update: true) }

  subject { operation.call(id: 1, **payload) }

  context 'when new proposal status is "approved"' do
    let(:payload) { { status: 'approved' } }

    it 'updates proposal status' do
      expect(proposal_repository).to receive(:update).with(1, status: 'approved')
      expect(subject).to eq Success(1)
    end

    context 'and conclusions exists' do
      let(:payload) { { status: 'approved', conclusions: 'test' } }

      it 'updates proposal status' do
        expect(proposal_repository).to receive(:update).with(1, status: 'approved', conclusions: 'test')
        expect(subject).to eq Success(1)
      end
    end

    context 'and client try tu update wrong information' do
      let(:payload) { { status: 'approved', other: 'test' } }

      it 'updates proposal status' do
        expect(proposal_repository).to receive(:update).with(1, status: 'approved')
        expect(subject).to eq Success(1)
      end
    end
  end

  context 'when new proposal status invalid' do
    let(:payload) { { status: 'invalid' } }

    it 'updates proposal status' do
      expect(proposal_repository).to_not receive(:update)
      expect(subject).to eq Success(1)
    end
  end

  context 'when new proposal status is "open"' do
    let(:payload) { { status: 'open' } }

    it 'updates proposal status' do
      expect(proposal_repository).to_not receive(:update)
      expect(subject).to eq Success(1)
    end
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:repo) { ProposalRepository.new }
    let(:proposal) { Fabricate.create(:proposal, status: 'open') }

    subject { operation.call(id: proposal.id, status: 'approved', conclusions: 'closed') }

    it 'updates proposal status' do
      expect(subject).to eq Success(proposal.id)
      expect(repo.find(proposal.id).status).to eq('approved')
    end
  end
end
