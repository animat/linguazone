class AddAttachmentsSwfToMedia < ActiveRecord::Migration
  def self.up
    add_column :medias, :swf_file_name, :string
    add_column :medias, :swf_content_type, :string
    add_column :medias, :swf_file_size, :integer
    add_column :medias, :swf_updated_at, :datetime
  end

  def self.down
    remove_column :medias, :swf_file_name
    remove_column :medias, :swf_content_type
    remove_column :medias, :swf_file_size
    remove_column :medias, :swf_updated_at
  end
end
