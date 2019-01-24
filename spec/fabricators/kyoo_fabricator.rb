Fabricator( :kyoo ) do
  uuid { SecureRandom.hex }
  name { Faker::TheThickOfIt.department }

  after_create do | kyoo |
    @user = Fabricate( :user )
    @policy = Fabricate( :policy, user: @user, kyoo: kyoo )
  end
end
