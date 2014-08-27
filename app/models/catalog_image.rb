class CatalogImage < ActiveRecord::Base

  has_attached_file :image, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket  => "linguazone", :s3_protocol => "http",
                    :url     => ":s3_domain_url", :path => "media/image/catalog/:name.:extension",
                    :styles  => { :large => "1040", :thumb => { :geometry => "100x75" } }

  def as_json(options={})
    {
      :photo_url     => self.image.url,
      :thumbnail_url => self.image.url(:thumb),
      :title         => self.name
    }
  end
end
