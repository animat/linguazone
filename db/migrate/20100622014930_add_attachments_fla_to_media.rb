class AddAttachmentsFlaToMedia < ActiveRecord::Migration
  def self.up
    add_column :medias, :fla_file_name, :string
    add_column :medias, :fla_content_type, :string
    add_column :medias, :fla_file_size, :integer
    add_column :medias, :fla_updated_at, :datetime
  end

  def self.down
    remove_column :medias, :fla_file_name
    remove_column :medias, :fla_content_type
    remove_column :medias, :fla_file_size
    remove_column :medias, :fla_updated_at
  end
end
