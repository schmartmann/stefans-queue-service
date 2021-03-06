module RenderHelper
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
    }, status: :bad_request
  end

  def missing_param( exception )
    render json: {
      errors: [
        {
          status: '422',
          title: 'Missing Param',
          detail: exception.message,
          code: '100'
        }
      ]
    }, status: :bad_request
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

  def fatal_error
    render json: {
      errors: [
        {
          status: '500',
          title: 'Bad Request',
          detail: 'Something went awray! That sucks!',
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
