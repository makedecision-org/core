# frozen_string_literal: true

RSpec.describe Organisation, type: :entity do
  describe '#public?' do
    subject { organisation.public? }

    context 'when organisation is public' do
      let(:organisation) { Organisation.new(public: true) }

      it { expect(subject).to be true }
    end

    context 'when organisation is private' do
      let(:organisation) { Organisation.new(public: false) }

      it { expect(subject).to be false }
    end
  end
end
