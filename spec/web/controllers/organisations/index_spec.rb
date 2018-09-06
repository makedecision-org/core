# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::Index, type: :action do
  let(:action) { described_class.new(operation: operation) }
  let(:params) { Hash[] }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { -> { Success([Organisation.new]) } }

    it { expect(subject).to be_success 200 }

    it 'returns list of proposals' do
      subject
      expect(action.organisations).to eq([Organisation.new])
    end
  end

  context 'whith a real dependency' do
    let(:action) { described_class.new }

    it { expect(subject).to be_success 200 }
  end
end
