RSpec.describe Proposals::Operations::Read, type: :list do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new }

  subject { operation.call(id: 1) }

  it { expect(subject).to eq Success(Proposal.new) }
end
