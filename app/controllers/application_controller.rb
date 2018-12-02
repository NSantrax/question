require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  include Pundit
  #protect_form_forgery with: :exeption

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_url, alert: exeption.message
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

end
