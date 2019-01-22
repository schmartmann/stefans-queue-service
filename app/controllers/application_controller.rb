class ApplicationController < ActionController::API
  include RequiresKyooFilter

  private

  def uuid
    @uuid ||= begin
      if result = params.permit( :uuid )
        result[ :uuid ]
      end
    end
  end

  def kyoo_uuid
    @kyoo_uuid ||= begin
      if result = params.permit( :kyoo_uuid )
        result[ :kyoo_uuid ]
      end
    end
  end

  def render_resource( resource )
    if resource.errors.empty?
      render json: resource
    else
      validation_error( resource )
    end
  end

  def missing_resource( exception )
    render json: {
      errors: [
        {
          status: '404',
          title: 'Missing resource',
          detail: exception.message,
          code: '104'
        }
      ]
    }
  end

  def validation_error( resource )
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
