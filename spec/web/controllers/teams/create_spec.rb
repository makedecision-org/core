RSpec.describe Web::Controllers::Teams::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { organisation_id: 'test', team: { organisation_id: 1, body: 'test', title: 'frontend' } } }

  subject { action.call(params) }

  context 'when operation return success result' do
    let(:operation) { -> (*_) { Success(Team.new(id: 1)) } }

    it { expect(subject).to redirect_to('/organisations/test/teams/1') }

    it do
      expect(operation).to receive(:call).with(
        organisation_id: 1,
        body: 'test',
        title: 'frontend'
      ).and_return(Success(Team.new(id: 1)))
      subject
    end
  end

  context 'when operation return failure result' do
    let(:operation) { -> (*_) { Failure([]) } }

    it { expect(subject).to be_success 200 }
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }
    let(:organisation) { Fabricate.create(:organisation, slug: 'test') }
    let(:params) { { organisation_id: organisation.slug, team: { organisation_id: organisation.id, title: 'test', body: 'test' } } }

    it { expect(subject).to be_success 200 }
    it { expect{ subject }.to change { TeamRepository.new.all.count }.by(1) }
  end
end
