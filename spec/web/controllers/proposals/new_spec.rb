RSpec.describe Web::Controllers::Proposals::New, type: :action do
  let(:action) { described_class.new(team_list_operation: operation) }
  let(:params) { { organisation_id: 'test' } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { ->(org_slug:) { Success([Team.new]) } }

    it { expect(subject).to be_success }

    it do
      action.call(params)
      expect(action.proposal).to eq Proposal.new
      expect(action.teams).to eq [Team.new]
    end
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success 200 }
  end
end
