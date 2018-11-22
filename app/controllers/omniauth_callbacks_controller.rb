class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  

  def facebook
    @kind = 'Facebook'
    authenticate
  end

  def twitter

  end

  def vkontakte
    @kind = 'Vkontakte'
    authenticate
  end

  def authenticate
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: @kind) if is_navigational_format?
    end
  end

  def set_email
   email = request.env['omniauth.auth'].info[:email]
    unless email
      render 'Rails.root/app/views/devise/registrations/email'
    end
    email
  end 
end
