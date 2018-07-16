class VerifyThePiesController < ApplicationController

  def new; end

  def ingredients
    respond_to do |format|
      format.html {
        render :new
      }
      format.json {
        send_file "#{Rails.root}/public/pies.json"
      }
    end
  end

end
