Fabricator( :policy, from: :policy ) do
  # user
  # kyoo
end

Fabricator( :policy_base, from: :policy ) do
end


Fabricator(:widget) do
  wockets(count: 5, fabricator: :wocket_base)
end

Fabricator(:wocket_base)

Fabricator(:wocket, from: :wocket) do
  widget
end
