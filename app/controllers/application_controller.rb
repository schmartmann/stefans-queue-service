class ApplicationController < ActionController::API
  include RenderHelper
  include RequiresKyooFilter
  include Dispatches
end
