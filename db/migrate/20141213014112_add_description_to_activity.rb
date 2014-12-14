class AddDescriptionToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :description, :string
    add_column :activities, :video_link, :string
  end
end
