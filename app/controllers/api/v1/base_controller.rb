class Api::V1::BaseController < ApplicationController
  #protect_from_forgery with: :exception
  before_action :doorkeeper_authorize!
  #protect_from_forgery with: :null_session
  protect_from_forgery unless: -> { request.format.json? } 

  
  respond_to :json


  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end