class Message < ApplicationRecord
  include UUID

  scope :unread, -> { where( read: false ) }

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

  def read_message
    unless self.read
      self.update( read: true )
    end
  end

  def content
    JSON.parse( self.message_body )
  end

  def object
    OpenStruct.new( self.content )
  end
end
