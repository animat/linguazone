class TempFile < StringIO
  attr_accessor :content_type, :original_filename, :tempfile

  def initialize(str, filename, content_type)
    @original_filename = filename
    @content_type = content_type
    file_path = "#{Rails.root}/tmp/#{filename}"
    @tempfile = File.new(file_path, "wb")
    @tempfile.write(str)
    @tempfile.close
    super(str)
  end
end
