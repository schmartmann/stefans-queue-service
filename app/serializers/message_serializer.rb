class KyooSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :message_body, :read

  belongs_to :kyoo
end
