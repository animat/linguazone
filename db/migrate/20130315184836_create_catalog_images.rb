class CreateCatalogImages < ActiveRecord::Migration
  def up
    add_column :medias, :image_name,         :string
    add_column :medias, :image_file_name,    :string
    add_column :medias, :image_content_type, :string
    add_column :medias, :image_file_size,    :integer
    add_column :medias, :image_updated_at,   :datetime
    change_column :medias, :assigned_to, :string, :null => true
    change_column :medias, :media_type_id, :integer, :null => true
    change_column_default :medias, :used_count, 0
  end

  def down
    remove_column :medias, :image_name
    remove_column :medias, :image_file_name
    remove_column :medias, :image_content_type
    remove_column :medias, :image_file_size
    remove_column :medias, :image_updated_at
  end
end
