class UserSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :email

  has_many :policies
end
