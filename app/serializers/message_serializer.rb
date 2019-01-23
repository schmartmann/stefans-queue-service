class KyooSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :message_body, :read, :created_at, :updated_at

  belongs_to :kyoo
end
