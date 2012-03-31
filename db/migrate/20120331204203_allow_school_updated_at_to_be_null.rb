class AllowSchoolUpdatedAtToBeNull < ActiveRecord::Migration
  def up
    change_column :schools, :updated_at, :timestamp, :null => true
  end

  def down
    change_column :schools, :updated_at, :datetime, :null => false
  end
end
