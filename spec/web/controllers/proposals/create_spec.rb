# frozen_string_literal: true

RSpec.describe Web::Controllers::Proposals::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { organisation_id: 'test', proposal: {} } }

  subject { action.call(params) }

  context 'when operation return success result' do
    let(:operation) { ->(*_) { Success(Proposal.new(id: 1)) } }

    it { expect(subject).to redirect_to('/organisations/test/proposals/1') }
  end

  context 'when operation return failure result' do
    let(:operation) { ->(*_) { Failure([]) } }

    it { expect(subject).to be_success 200 }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }
    let(:organisation) { Fabricate.create(:organisation, slug: 'test') }
    let(:team) { Fabricate.create(:team, organisation_id: organisation.id) }
    let(:params) { { organisation_id: organisation.slug, proposal: { team_id: team.id, title: 'test', body: 'test' } } }

    it { expect(subject).to be_success 200 }
    it { expect { subject }.to change { ProposalRepository.new.all.count }.by(1) }
  end
end
