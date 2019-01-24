Fabricator( :kyoo ) do
  uuid { SecureRandom.hex }
  name { "#{ Faker::TheThickOfIt.department }-#{ SecureRandom.hex }" }
end

Fabricator( :kyoo_with_users, from: :kyoo ) do
  after_create do | kyoo |
    unless kyoo.users.any?
      user = Fabricate( :user )
      policy = Fabricate( :policy, user: user, kyoo: kyoo )
    end
  end
end
