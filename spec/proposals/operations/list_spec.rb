RSpec.describe Proposals::Operations::List, type: :list do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new }

  subject { operation.call }

  it { expect(subject).to eq Success([]) }
end
