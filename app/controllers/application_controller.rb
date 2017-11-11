class ApplicationController < ActionController::Base

  def is_admin?
    current_user && current_user.is_admin?
  end

  def authenticate_admin!
    unless is_admin?
      redirect_to 'http://www.google.com'
    end
  end

end