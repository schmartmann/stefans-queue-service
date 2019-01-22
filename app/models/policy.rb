class Policy < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    user_uuid
    kyoo_uuid
  ).freeze

  #----------------------------------------------------------------------------
  # validations

  validates :user_uuid,
            presence: true,
            uniqueness: { scope: :kyoo_uuid }

  validates :kyoo_uuid,
            presence: true,
            uniqueness: { scope: :user_uuid }

  #----------------------------------------------------------------------------
  # associations

  belongs_to  :user
  belongs_to  :kyoo
end
