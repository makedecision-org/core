# frozen_string_literal: true

module Auth
  module Oauth
    class GithubCallback < WebBouncer::OauthCallback
      def call(oauth_response)
        account = auth_identitie_repo.find_account(uid: oauth_response['uid'], type: 'github')

        unless account
          account = account_repo.create(account_data(oauth_response))
          auth_identitie_repo.create(account_id: account.id, **oauth_data(oauth_response))
        end

        Success(account)
      end

      private

      def auth_identitie_repo
        @auth_identitie_repo ||= AuthIdentityRepository.new
      end

      def account_repo
        @account_repo ||= AccountRepository.new
      end

      def oauth_data(data)
        {
          uid: data['uid'],
          token: data['credentials']['token'],
          type: 'github'
        }
      end

      def account_data(data)
        {
          uuid: SecureRandom.uuid,
          login: data['info']['nickname'],
          email: data['info']['email'],
          name: data['info']['name'],
          bio: data['extra']['raw_info']['bio'],
          role: 'user',
          avatar_url: data['info']['image']
        }
      end
    end
  end
end
