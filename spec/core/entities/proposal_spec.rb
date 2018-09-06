# frozen_string_literal: true

RSpec.describe Proposal, type: :entity do
  describe '#open?' do
    [
      { status: 'open',     expected: true },
      { status: 'approved', expected: false },
      { status: 'denied',   expected: false }
    ].each do |test|
      context "when proposal status is #{test[:status]}" do
        let(:entity) { Proposal.new(status: test[:status]) }

        it { expect(entity.open?).to eq(test[:expected]) }
      end
    end
  end

  describe '#approved?' do
    [
      { status: 'open',     expected: false },
      { status: 'approved', expected: true },
      { status: 'denied',   expected: false }
    ].each do |test|
      context "when proposal status is #{test[:status]}" do
        let(:entity) { Proposal.new(status: test[:status]) }

        it { expect(entity.approved?).to eq(test[:expected]) }
      end
    end
  end

  describe '#denied?' do
    [
      { status: 'open',     expected: false },
      { status: 'approved', expected: false },
      { status: 'denied',   expected: true }
    ].each do |test|
      context "when proposal status is #{test[:status]}" do
        let(:entity) { Proposal.new(status: test[:status]) }

        it { expect(entity.denied?).to eq(test[:expected]) }
      end
    end
  end
end
