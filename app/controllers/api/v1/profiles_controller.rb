class Api::V1::ProfilesController < Api::V1::BaseController
  respond_to :json

  def me
    respond_with current_resource_owner
  end

  def index
    @profiles = User.all.reject {|x| x == current_resource_owner }
    respond_with @profiles
  end

end