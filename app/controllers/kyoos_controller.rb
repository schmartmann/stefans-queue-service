class KyoosController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def query
    render json: current_user.kyoos
  end
end
