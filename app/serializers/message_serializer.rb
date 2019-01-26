class MessageSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :message_body, :read, :created_at, :updated_at
end
