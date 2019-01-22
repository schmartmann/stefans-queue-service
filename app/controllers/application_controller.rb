class ApplicationController < ActionController::API
  include RenderHelper
  include RequiresKyooFilter
end
