class MessagesController < ApplicationController
  respond_to :json
  require_kyoo

  def query
    render json: kyoo.messages
  end

  def kyoo
      @kyoo ||= current_user.kyoos.where( uuid: kyoo_uuid ).first
  end
end
