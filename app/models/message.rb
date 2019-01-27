class Message < ApplicationRecord
  include UUID
  include Dispatches

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
  # hooks

  before_save   :json
  # after_create  :dispatch_message

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

  def kyoo_endpoints
    self.kyoo_subscription_endpoints
  end

  def dispatch_message
    # url = 'http://localhost:8000/messages'
    url = nil
    unless url.nil?
      Dispatches::Dispatcher.new( url, self.message_body ).send
    end
  end

  def json
    # ensure message body is saved as valid json
    body = self.message_body
    JSON.parse( body ) rescue body.to_json
  end
end
