require 'devise/jwt/test_helpers'

module AuthHelpers
  def auth_headers( user )
    @auth_headers ||=
      begin
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        Devise::JWT::TestHelpers.auth_headers( headers, user )
      end
  end
end
