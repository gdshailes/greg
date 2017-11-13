class Image < ActiveRecord::Base

  def uploaded_file(incoming_file, size_width, size_height)
    # self.filename = incoming_file.original_filename
    # self.filetype = incoming_file.content_type
    self.filedata = MiniMagick::Image.read(incoming_file.read).resize("#{size_width}x#{size_height}").to_blob

  end

end
