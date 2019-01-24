class PolicySerializer < ActiveModel::Serializer
  attributes :id, :uuid

  belongs_to :user
  belongs_to :kyoo
end
