# frozen_string_literal: true

RSpec.describe AuthIdentityRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#find_account' do
    let(:account) { Fabricate.create(:account) }
    let(:auth_identity) { repo.create(account_id: account.id, uid: '123321', type: 'github') }

    subject { repo.find_account(uid: uid, type: type) }

    context 'when account exist' do
      let(:type) { auth_identity.type }
      let(:uid) { auth_identity.uid }

      it { expect(subject).to eq account }
    end

    context 'when account does not exist' do
      let(:type) { 'other' }
      let(:uid) { auth_identity.uid }

      it { expect(subject).to eq nil }
    end
  end
end
