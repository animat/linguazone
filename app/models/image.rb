class Image < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "linguazone",
    :s3_protocol => "http",
    :url => ":s3_domain_url",
    :path => "media/image/game/:id.:extension"
end
