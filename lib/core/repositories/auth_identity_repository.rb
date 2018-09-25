# frozen_string_literal: true

class AuthIdentityRepository < Hanami::Repository
  associations do
    belongs_to :account
  end

  def find_account(uid:, type:)
    aggregate(:account).where(uid: uid, type: type).map_to(AuthIdentity).one&.account
  end
end
