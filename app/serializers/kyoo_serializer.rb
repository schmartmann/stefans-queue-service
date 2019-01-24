class KyooSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :created_at, :updated_at

  has_many :messages
end
