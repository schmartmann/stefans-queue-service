module RequireKyooFilter
  class RequiresKyoo

    def before( controller )
      if controller.kyoo_uuid.nil?
        puts "The 'kyoo_uuid' parameter is required"
      end
    end
  end

  module ClassMethods
    def requires_kyoo( options = {} )
      before_action( RequiresKyoo.new, options )
    end

    def self.included( controller )
      controller.extend( ClassMethods )
    end

    def kyoo_uuid
      params[ :kyoo_uuid ]
    end
  end
end
