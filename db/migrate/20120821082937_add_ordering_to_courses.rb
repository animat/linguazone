class AddOrderingToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :ordering, :int
  end
  
  def down
    remove_column :courses, :ordering
  end
end
