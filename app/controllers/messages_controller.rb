class MessagesController < ApplicationController
  respond_to :json
  require_kyoo

  def query
    render json: kyoo.messages
  end

  def kyoo
    @kyoo ||= current_user.kyoos.find_by( uuid: kyoo_uuid )
  end
end
