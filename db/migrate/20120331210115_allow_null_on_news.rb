class AllowNullOnNews < ActiveRecord::Migration
  def up
    change_column :news, :created_at, :timestamp, :null => true
    change_column :news, :updated_at, :timestamp, :null => true
  end

  def down
    change_column :news, :created_at, :timestamp, :null => false
    change_column :news, :updated_at, :datetime, :null => false
  end
end
