# frozen_string_literal: true

module Auth
  module Oauth
    class GithubCallback < WebBouncer::OauthCallback
      def call(oauth_response)
        Success(oauth_response)
      end

      private

      def oauth_data(data)
        {
          uid:        data['uid'],
          token:      data['credentials']['token'],
          login:      data['info']['nickname'],
          email:      data['info']['email'],
          name:       data['info']['name'],
          avatar_url: data['info']['image']
        }
      end
    end
  end
end
