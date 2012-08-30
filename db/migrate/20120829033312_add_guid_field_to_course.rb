class AddGuidFieldToCourse < ActiveRecord::Migration
  def up
    add_column :courses, :guid, :string
  end
  
  def down
    remove_column :courses, :guid
  end
end
