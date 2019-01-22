class KyooSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name

  has_many :messages
end
