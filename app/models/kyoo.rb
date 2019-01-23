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

  has_many :messages, dependent: :destroy
  has_many :policies, dependent: :destroy

  has_many :users, through: :policies
end
