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
    kyoo = current_user.
            kyoos.
            new( kyoo_params )

    kyoo.save
    render_resource( kyoo )
  end

  def destroy
    kyoo = current_user.
            kyoos.
            where( uuid: uuid ).
            first

    unless kyoo.nil?
      unless kyoo.destroy
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
    @kyoo ||= current_user.
                kyoos.
                where( uuid: uuid )
  end

  def uuid
    @uuid ||= params[ :uuid ]
  end

  def kyoo_params
    params.
      require( :kyoo ).
      permit( PERMITTED_ATTRIBUTES )
  end
end
