class KyoosController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  PERMITTED_ATTRIBUTES = %i(
    id
    uuid
    name
  ).freeze

  def query
    render json: kyoos
  end

  def read
    render json: kyoo
  end

  def write
    unless existing_kyoo
      kyoo = current_user.kyoos.new( kyoo_params )

      kyoo.save
      render_resource( kyoo )
    else
      render_resource( existing_kyoo )
    end
  end

  def destroy
    kyoo = Kyoo.find_by( uuid: uuid )

    unless kyoo.nil?
      if kyoo.destroy
        render json: {
            message: "Kyoo #{ uuid } successfully deleted"
          }
      else
        fatal_error
      end
    else
      missing_resource( Exception.new( "Could not retrieve kyoo #{ uuid }" ) )
    end
  end

  private

  def kyoos
    @kyoos ||= current_user.kyoos
  end

  def kyoo
    @kyoo ||= current_user.kyoos.where( uuid: uuid )
  end

  def uuid
    @uuid ||= params[ :uuid ]
  end

  def existing_kyoo
    @existing_kyoo ||= kyoos.where( kyoo_params ).first
  end

  def kyoo_params
    params.require( :kyoo ).permit( PERMITTED_ATTRIBUTES )
  end
end
