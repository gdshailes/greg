class BoriscamController < ActionController::Base
  protect_from_forgery with: :exception

  def index

    # Written By : GDS
    # Date       : 15/11/2016

  end

  def upload

    uploaded_io = params[:picture]

    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

  end

end