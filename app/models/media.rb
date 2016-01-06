class Media < ActiveRecord::Base
  set_table_name 'medias'

  has_many :media_keywords
  belongs_to :media_category
  belongs_to :media_type

  before_save :set_path_and_artist

  # TODO: Bring back paperclip for attached media!
  #has_attached_file :fla, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
  #                  :bucket => "linguazone", :s3_protocol => "http",
  #                  :url => ":s3_domain_url", :path => "media/image/:media_category/:name.:extension"
  #has_attached_file :swf, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
  #                  :bucket => "linguazone", :s3_protocol => "http",
  #                  :url => ":s3_domain_url", :path => "media/image/:media_category/:name.:extension"
  #
  # validates_attachment_size :swf, :less_than => 40.kilobytes
  # validates_attachment_content_type :swf, :content_type => "application/x-shockwave-flash"
  # validates_attachment_size :fla, :less_than => 5.megabytes
  # validates_attachment_content_type :fla, :content_type => "application/octet-stream"
  # TODO: Implement these validations

  def set_path_and_artist
    self.path = "media/image/"+media_category.name+"/"
  end
end
