require 'fileutils'

class BoriscamController < ActionController::Base

  # Written By : GDS
  # Date       : 15/11/2016

  def index
    # Get latest 20 photos, in reverse chronological order.
    @images = Image.order(created_at: :desc).limit(20)
  end


  def upload
    img = Image.new
    img.uploaded_file params['datafile']
    if img.filetype != "image/jpeg"
      head :unsupported_media_type
    else
      img.save
      Image.order('created_at desc').offset(20).destroy_all
      head :ok
    end
  end

end