module RequireKyooFilter
  class RequiresKyoo

    def before( controller )
      if controller.kyoo_uuid.present?
        if kyoo_policy.present?
          kyoo_policy.kyoo
        else
          puts 'Current user has no policy for the request kyoo'
        end
      else
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

    def kyoo_policy
      current_user.policies.where( kyoo_uuid: kyoo_uuid ).first
    end
  end
end
