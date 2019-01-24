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


Fabricator( :kyoo_with_messages, from: :kyoo ) do
  after_create do | kyoo |
    unless kyoo.users.any?
      user = Fabricate( :user )
      policy = Fabricate( :policy, user: user, kyoo: kyoo )
    end

    unless kyoo.messages.any?
      rand( 1..5 ).times do
        Fabricate( :message, kyoo: kyoo )
      end
    end
  end
end
