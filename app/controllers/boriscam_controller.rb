require 'fileutils'

class BoriscamController < ActionController::Base
  protect_from_forgery with: :exception

  def index

    # Written By : GDS
    # Date       : 15/11/2016

  end

  def upload

    uploaded_io = params[:picture]

    dest_path = Rails.root.join('app', 'assets', 'images')
    new_pic = dest_path.join('boris_001.jpg')


    # Delete 20
    File.delete(dest_path.join('boris_020.jpg')) if File.exist?(dest_path.join('boris_020.jpg'))

    # Rename 1-19 to 2-20
    i = 20
    while i > 1 do
      i -= 1

      rename_from = dest_path.join('boris_' + ('000' + i.to_s).last(3) + '.jpg')

      if File.exist?(rename_from)
        rename_to = dest_path.join('boris_' + ('000' + (i + 1).to_s).last(3) + '.jpg')
        FileUtils.mv(rename_from, rename_to)
      end

    end

    File.open(new_pic, 'wb') do |file|

      # Save new pic as 1
      file.write(uploaded_io.read)

    end

  end

end