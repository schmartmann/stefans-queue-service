Fabricator( :policy ) do
  uuid { SecureRandom.hex }

  before_create do | policy |
    if policy.user.nil?
      policy.user = Fabricate( :user )
    end

    if policy.kyoo.nil?
      policy.kyoo = Fabricate( :kyoo )
    end    
  end
end
