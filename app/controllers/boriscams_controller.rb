require 'fileutils'

class BoriscamsController < ApplicationController

  def index
    @images = BorisCamImage.order(created_at: :desc).limit(20)
  end

  def create
    img = BorisCamImage.new
    img.uploaded_file params['datafile']
    if img.filetype != 'image/jpeg'
      head :unsupported_media_type
    else
      img.save!
      BorisCamImage.order('created_at desc').offset(20).destroy_all
      head :ok
    end
  end

end