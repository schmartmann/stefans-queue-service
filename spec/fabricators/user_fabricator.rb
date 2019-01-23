Fabricator( :user, from :user ) do
  email { 'foo@bar.co.jp' }
  password { 'password' }
  policies( count: 1, fabricator: :policy_base )
end
