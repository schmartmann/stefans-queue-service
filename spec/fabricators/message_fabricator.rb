Fabricator( :message ) do
  uuid { SecureRandom.hex }
  message_body { { "hello": "world" } }
  read { false }
end
