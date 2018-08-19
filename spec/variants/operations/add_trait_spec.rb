RSpec.describe Variants::Operations::AddTrait, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new }

  subject { operation.call(variant_id: 1, value: 2, type: 3) }

  it { expect(subject).to eq Success(1) }
end
