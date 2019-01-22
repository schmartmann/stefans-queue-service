class KyoosController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def query
    render json: Kyoo.all
  end
end
