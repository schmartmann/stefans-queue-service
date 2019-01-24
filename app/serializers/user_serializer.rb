class UserSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :email, :created_at, :updated_at

  has_many :policies, dependent: :destroy
end
