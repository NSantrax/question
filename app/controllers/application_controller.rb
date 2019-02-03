require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  include Pundit
  #protect_from_forgery with: :null_session, only: [:create]

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_url, alert: exeption.message
  end
  
  rescue_from Exception, :with => :handle_exception

  def handle_exception
    flash[:error] = error.message
    redirect_to request.referer || root_path
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  private
 
    
    def user_not_authorized(exception)

      policy_name = exception.policy.class.to_s.underscore
      
      respond_to do |format|
        format.html { redirect_to (request.referrer || root_path), alert: exception.message }
        format.json { render json: { type: 'error', message: t("#{ policy_name }.#{ exception.query }") }, status: :unauthorized}
        
      end 
    end

end
