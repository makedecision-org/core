# frozen_string_literal: true

RSpec.describe Polls::Operations::Vote, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new }
  let(:payload) { {} }

  subject { operation.call(payload: payload) }

  it { expect(subject).to be_success }
end
