factory :user do
  email { 'foo@bar.co.jp' }
  password { SecureRandom.hex }
end
