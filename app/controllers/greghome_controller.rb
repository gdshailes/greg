class GreghomeController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_admin!, only: :greghome

  def index; end

  def denied; end

  def root
    if is_admin?
      render :index
    else
      redirect_to ratrace_url
    end
  end

end
