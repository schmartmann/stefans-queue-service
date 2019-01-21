class JWTBlacklist < ApplicationRecord
  include Devie::JWT::RevocationStrategies::Blacklist

  self.table_name = 'jwt_blacklists'
end
