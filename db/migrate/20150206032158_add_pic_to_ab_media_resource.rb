class AddPicToAbMediaResource < ActiveRecord::Migration
  def change
    add_attachment :ab_media_resources, :pic
  end
end
