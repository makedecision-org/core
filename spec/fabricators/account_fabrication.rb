# frozen_string_literal: true

Fabricator(:account) do
  name 'Anton'
  email 'test@md.com'
  login 'antonlogin'

  role 'user'
end

Fabricator(:admin_account) do
  name 'Anton'
  email 'test@md.com'
  login 'antonlogin'

  role 'admin'
end
