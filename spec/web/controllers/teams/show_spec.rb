# frozen_string_literal: true

RSpec.describe Web::Controllers::Teams::Show, type: :action do
  let(:action) { described_class.new(operation: operation, proposals_list_operation: proposals_list_operation) }
  let(:proposals_list_operation) { ->(*) {} }
  let(:params) { { 'rack.session' => session, organisation_id: 'test', id: 1 } }
  let(:session) { { account: Account.new(id: 1) } }

  subject { action.call(params) }

  context 'when account not login' do
    let(:operation) { ->(*) {} }
    let(:session) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when operation returns success result' do
    let(:operation) { ->(org_slug:, id:) { Success(Team.new) } }
    let(:proposals_list_operation) { ->(team_id:) { Success('open' => [Proposal.new]) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.team).to eq(Team.new)
      expect(action.proposals).to eq('open' => [Proposal.new])
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(org_slug:, id:) { Failure(:not_found) } }
    let(:proposals_list_operation) { ->(team_id:) { Success('open' => [Proposal.new]) } }

    it do
      expect(proposals_list_operation).to_not receive(:call)
      expect(subject).to redirect_to('/organisations/test')
    end
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }
    let(:team) { Fabricate.create(:team) }
    let(:params) { { organisation_id: 'test', id: team.id } }

    it { expect(subject).to be_success 200 }
  end
end
