class Image < ActiveRecord::Base

  def uploaded_file(incoming_file)
    self.filename = incoming_file.original_filename
    self.filetype = incoming_file.content_type
    self.filedata = MiniMagick::Image.read(incoming_file.read).resize('500x2000').to_blob

  end

end
