RSpec.describe Web::Controllers::Variants::Create, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { { proposal_id: 1, name: 'test variant' } }

  subject { action.call(params) }

  let(:operation) { -> (proposal_id:, name:) { Success(Variant.new) } }

  it { expect(subject).to redirect_to('/proposals/1') }

  context 'with real dependencies' do

  end
end
