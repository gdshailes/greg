class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    existing_user = User.find_by(email: @user.email)
    if existing_user
      @user = existing_user
    end
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end