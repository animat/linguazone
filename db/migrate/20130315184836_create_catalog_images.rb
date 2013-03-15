class CreateCatalogImages < ActiveRecord::Migration
  def change
    add_column :medias, :string,   :name
    add_column :medias, :string,   :image_file_name
    add_column :medias, :string,   :image_content_type
    add_column :medias, :integer,  :image_file_size
    add_column :medias, :datetime, :image_updated_at
  end
end
