require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json
  include Pundit
  #protect_form_forgery with: :exeption

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_url, alert: exeption.message
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      respond_to do |format|
        format.html { redirect_to(request.referrer || root_path) }
        format.json { render json: @record.errors.full_messages, status: :unprocessable_entity}
      end
    end

end
