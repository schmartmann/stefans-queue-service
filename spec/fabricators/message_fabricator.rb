Fabricator( :message ) do
  uuid { SecureRandom.hex }
  message_body { { "hello": "world" } }
  read { false }

  before_create do | message |
    @user = Fabricate( :user )
    @kyoo = Fabricate( :kyoo )
    @policy = Fabricate( :policy, user: @user, kyoo: @kyoo )
    message.kyoo = @kyoo
  end
end
