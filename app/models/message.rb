class Message < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    read?
    message
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  validates :read?,
            presence: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :kyoo
end
