class GregworkController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_admin!, only: :gregwork

  def index; end

  def denied; end

  def root
    if is_greg?
      render :gregwork
    else
      render :index
    end
  end

  def gregwork; end

end
