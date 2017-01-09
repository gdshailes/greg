require 'fileutils'

class BoriscamController < ActionController::Base

  def index

    # Written By : GDS
    # Date       : 15/11/2016


    # Get latest 20 photos, in reverse chronological order.
    @images = Image.order(created_at: :desc).limit(20)

  end

  def upload

    @image = Image.new
    @image.uploaded_file params['datafile']

##    if @image.filetype != "image/jpeg"
##      render nothing: true, status: 415 # Unsupported media type
##    else
      @image.save
      Image.order('created_at desc').offset(20).destroy_all
      render nothing: true, status: 200 # okay
##    end

  end

end