class EndpointSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :callback_url, :created_at, :updated_at

  belongs_to :subscription
end
