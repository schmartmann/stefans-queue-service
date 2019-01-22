class ApplicationController < ActionController::API
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
