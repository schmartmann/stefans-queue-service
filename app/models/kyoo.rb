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
  has_many :subscriptions
  has_many :endpoints, through: :subscriptions

  #----------------------------------------------------------------------------
  # associations

  def read_messages
    self.messages.where( read: true )
  end

  def unread_messages
    self.messages.where( read: false )
  end

  def user_emails
    self.users.pluck( :email )
  end
end
