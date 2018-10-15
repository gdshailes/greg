class GreghomeController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_admin!, only: :greghome

  def index; end

  def denied; end

  def root
    if is_greg?
      render :greghome
    else
      render :index
    end
  end

  def greghome; end

end
