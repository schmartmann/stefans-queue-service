module Kyoos
  class MessagesController < ApplicationController
    respond_to :json

    require_kyoo

    def query
      render json: kyoo.messages
    end
  end
end
