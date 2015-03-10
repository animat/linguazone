require "open-uri"
require 'open-uri'

module AcceptUrls
  attr_accessor :image_url, :image_remote_url

  def self.included(base)
    base.class_eval do
      before_validation :download_remote_image, :if => :valid_image_url?
      validate :valid_image_type_or_url
    end
  end

  private

  def valid_image_type_or_url
    return if ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'].include?(self.image_content_type)
    if image_url_provided? && self.image_file_name.blank?
      errors.add 'Sorry! ', "Invalid URL"
      errors.messages.delete :image_file_name
    elsif self.image_content_type.present?
      errors.add 'Sorry! ', "Incorrect file format"
      errors.messages.delete :image
    else
      errors.add :image, "can't be blank"
    end
  end

  def valid_image_url?
    return false unless image_url_provided?
    io = open(URI.parse(image_url))
    true
  rescue Exception => e
    false
  end

  def image_url_provided?
    self.image_url.present?
  end

  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_url
  end

  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split("/").last; end
    io.original_filename.blank? ? nil : io
  end
end


class Image < ActiveRecord::Base
  include AcceptUrls
  belongs_to :user

  has_attached_file :image,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => "linguazone",
    :s3_protocol => "http",
    :url => ":s3_domain_url",
    :path => "media/image/game/:id.:extension"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def remote_url=(url)
    self.image = open(url)
  end
end
