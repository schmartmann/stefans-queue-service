class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :uuid

  belongs_to :user
  belongs_to :kyoo
  has_many :endpoints
end
