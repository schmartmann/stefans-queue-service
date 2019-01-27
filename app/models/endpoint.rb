class Endpoint < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  # validates :name,
  #           presence: true,
  #           uniqueness: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :subscription

  #----------------------------------------------------------------------------
  # associations

end
