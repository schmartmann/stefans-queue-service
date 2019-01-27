class Endpoint < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    callback_url
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  validates :callback_url,
            presence: true,
            uniqueness: true,
            url: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :subscription
  has_many :kyoos, through: :subscriptions
  #----------------------------------------------------------------------------
  # methods
end
