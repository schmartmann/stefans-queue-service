class Subscription < ApplicationRecord
  include UUID

  #----------------------------------------------------------------------------
  # attributes

  ATTRIBUTES = %i(
    uuid
    id
    kyoo_id
    user_id
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

  belongs_to :kyoo
  belongs_to :user
  has_many   :endpoints

end
