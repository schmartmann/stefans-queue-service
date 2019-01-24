class MessagesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  require_kyoo

  PERMITTED_ATTRIBUTES = %i(
    id
    uuid
    message_body
    read
  ).freeze

  def query
    render json: messages
  end

  def read
    render json: message
  end

  def write
    message = kyoo.messages.new( message_params )

    message.save
    render_resource( message )
  end

  def update
    if new_message_read_state

      message = current_user.
                  kyoos.
                  where( uuid: kyoo_uuid ).
                  first.
                  messages.
                  where( uuid: uuid ).
                  first

      if message.read_message
        render_resource( message )
      else
        missing_param( Exception.new( "Cannot set unread state on read message #{ uuid }" ) )
      end
    end
  end

  def destroy
    message = current_user.
                kyoos.
                where( uuid: kyoo_uuid ).
                first.
                messages.
                where( uuid: uuid ).
                first

    unless message.nil?
      unless message.destroy
        fatal_error
      end
    else
      missing_resource( Exception.new( "Could not retrieve message #{ uuid }" ) )
    end
  end

  private

  def kyoo
    @kyoo ||= current_user.kyoos.where( uuid: kyoo_uuid ).first
  end

  def uuid
    @uuid ||= params[ :uuid ]
  end

  def messages
    @messages ||= kyoo.messages.unread
  end

  def message
    @message ||= kyoo.messages.unread.where( uuid: uuid )
  end

  def new_message_read_state
    @message_read ||= message_params[ :read ]
  end

  def message_params
    params.
      require( :message ).
      permit( PERMITTED_ATTRIBUTES )
  end
end
