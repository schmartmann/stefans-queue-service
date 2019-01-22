class KyooSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :message, :read

  belongs_to :kyoo
end
