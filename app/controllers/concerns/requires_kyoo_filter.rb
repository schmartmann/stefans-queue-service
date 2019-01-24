module RequiresKyooFilter
  extend ActiveSupport::Concern

  class RequiresKyoo

    def before( controller )
      if controller.kyoo_uuid.nil?
        controller.missing_param( Exception.new( "The param 'kyoo_uuid' is required" ) )
      end
    end
  end

  module ClassMethods

    def require_kyoo( options = {} )
      before_action( RequiresKyoo.new, options )
    end

  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end

  def kyoo_uuid
    params[ :kyoo_uuid ]
  end
end
