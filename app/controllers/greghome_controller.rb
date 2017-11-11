class GreghomeController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_admin!, only: :greghome

  def index

  end

  def denied

  end

end
