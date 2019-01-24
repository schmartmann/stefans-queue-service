Fabricator( :message ) do
  uuid { SecureRandom.hex }
  message_body { { "hello": "world" } }
  read { false }

  before_create do | message |
    unless message.kyoo.present?
      kyoo = Fabricate( :kyoo )
      message.kyoo = kyoo
    end

    unless message.kyoo.users.any?
      user = Fabricate( :user )
      policy = Fabricate( :policy, user: user, kyoo: kyoo )
    end
  end
end
