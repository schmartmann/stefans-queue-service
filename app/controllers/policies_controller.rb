class PoliciesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  PERMITTED_ATTRIBUTES = %i(
    id
    uuid
    kyoo_id
    policy_id
  )

  def query
    render json: user_policies
  end

  def read
    render json: user_policy
  end

  def write
    policy = current_user.policies.new( policy_params )

    policy.save
    render_resource( policy )
  end

  private

  def user_policies
    @user_policies ||= current_user.policies
  end

  def user_policy
    @user_policy ||= current_user.policies.where( uuid: policy_uuid )
  end

  def policy_uuid
    @policy_uuid ||= params[ :uuid ]
  end

  def policy_params
    params.require( :policy ).permit( PERMITTED_ATTRIBUTES )
  end
end
