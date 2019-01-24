class Policy < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    user_id
    kyoo_id
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  validates :user_id,
            presence: true,
            uniqueness: { scope: :kyoo_id }

  validates :kyoo_id,
            presence: true,
            uniqueness: { scope: :user_id }

  #----------------------------------------------------------------------------
  # associations

  belongs_to  :user
  belongs_to  :kyoo
end
