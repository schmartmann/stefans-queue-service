class Kyoo < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    name
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  validates :name,
            presence: true,
            uniqueness: true

  #----------------------------------------------------------------------------
  # associations

  has_many :messages
  has_many :policies
end
