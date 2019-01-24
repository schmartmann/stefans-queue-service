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
      messages = []

      rand( 1..5 ).times do | time |
        messages << Fabricate( :message, kyoo: kyoo )
      end

      rand( 1..4 ).times do | time |
        messages[ rand( messages.length ) ].update( read: true )
      end
    end
  end
end
