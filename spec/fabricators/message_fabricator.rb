Fabricator( :message ) do
  kyoo
  uuid { SecureRandom.hex }
  message_body { { "hello": "world" } }
  read { false }
end
