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
    existing_user = User.find_by(email: @user.email)
    if existing_user
      @user = existing_user
    end
    sign_in_and_redirect @user, event: :authentication
  end

end