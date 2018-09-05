RSpec.describe Web::Controllers::Teams::Show, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { organisation_id: 'test', id: 1 } }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> (org_slug:, id:) { Success(Team.new) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.team).to eq(Team.new)
    end
  end

  context 'when operation returns failure result' do
    let(:operation) { -> (org_slug:, id:) { Failure(:not_found) } }

    it { expect(subject).to redirect_to('/organisations/test') }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }
    let(:team) { Fabricate.create(:team) }
    let(:params) { { organisation_id: 'test', id: team.id } }

    it { expect(subject).to be_success 200 }
  end
end
