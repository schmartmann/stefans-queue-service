Fabricator( :message ) do
  uuid { SecureRandom.hex }
  message{ { "hello": "world" } }
  read { false }
end
