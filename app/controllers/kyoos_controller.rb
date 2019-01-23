class KyoosController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  PERMITTED_ATTRIBUTES = %i(
    id
    uuid
    name
  )

  def query
    render json: kyoos
  end

  def read
    render json: kyoo
  end

  def write
  end

  private

  def kyoos
    @kyoos ||= current_user.kyoos
  end

  def kyoo
    @kyoo ||= current_user.kyoos.where( params[ :uuid  ] )
  end

  def kyoo_params
    params.require( :kyoo ).permit( PERMITTED_ATTRIBUTES )
  end
end
