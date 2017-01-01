require 'fileutils'

protect_from_forgery

class BoriscamController < ActionController::Base
  protect_from_forgery with: :exception

  def index

    # Written By : GDS
    # Date       : 15/11/2016

  end

  def upload

    # build a photo and pass it into a block to set other attributes
    @image = Image.new(params[:picture]) do |t|
      if params[:picture][:data]
        t.data = params[:picture][:data].read
      end
    end

    @image.Save

  end

end