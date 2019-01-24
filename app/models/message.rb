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

  validates :read, inclusion: { in: [ true, false ] }
  validates :message_body, presence: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :kyoo
end
