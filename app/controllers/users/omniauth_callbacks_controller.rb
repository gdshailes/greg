class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    get_user_from_omniauth "Facebook"
  end

  def google
    get_user_from_omniauth "Google"
  end

  def failure
    redirect_to root_path
  end

  private

  def get_user_from_omniauth(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
  end

end