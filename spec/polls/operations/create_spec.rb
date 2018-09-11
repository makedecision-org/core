# frozen_string_literal: true

RSpec.describe Polls::Operations::Create, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new }

  subject { operation.call }

  it { expect(subject).to eq Success(Poll.new) }
end
