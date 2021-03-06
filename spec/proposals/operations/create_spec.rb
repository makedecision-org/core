# frozen_string_literal: true

RSpec.describe Proposals::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(proposal_repository: proposal_repository, org_repository: org_repository) }
  let(:proposal_repository) { double(:proposal_repository, create: Proposal.new) }
  let(:org_repository) { double(:org_repository, find_id: 1) }

  subject { operation.call(title: 'test title', body: 'test **body**', organisation_slug: 'test', team_id: 1) }

  it 'saves a new proposal' do
    expect(proposal_repository).to receive(:create).with(
      organisation_id: 1,
      body: "<p>test <strong>body</strong></p>\n",
      raw_body: 'test **body**',
      title: 'test title',
      team_id: 1
    ).and_return(Proposal.new)

    expect(subject).to eq Success(Proposal.new)
  end

  context 'whith real dependencies' do
    let(:operation) { described_class.new }
    let(:organisation) { Fabricate.create(:organisation, slug: 'test') }
    let(:team) { Fabricate.create(:team, organisation_id: organisation.id) }

    subject { operation.call(title: 'test title', body: 'test **body**', organisation_slug: organisation.slug, team_id: team.id) }

    it { expect(subject).to be_success }
    it { expect { subject }.to change { ProposalRepository.new.all.count }.by(1) }
  end
end
