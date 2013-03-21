class CreateCatalogImages < ActiveRecord::Migration
  def change
    add_column :medias, :image_name,         :string
    add_column :medias, :image_file_name,    :string
    add_column :medias, :image_content_type, :string
    add_column :medias, :image_file_size,    :integer
    add_column :medias, :image_updated_at,   :datetime
  end
end
