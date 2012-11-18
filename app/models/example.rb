class Example < ActiveRecord::Base
  belongs_to :language
  belongs_to :activity

  has_attached_file :image,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "linguazone",
    :s3_protocol => "http",
    :url => ":s3_domain_url",
    :path => "media/image/example/:id.:extension"
end
