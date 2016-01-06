class ChangeSchoolNameToString < ActiveRecord::Migration
  def up
    remove_index :schools, :name => "school_index"
    change_column :schools, :name, :string
  end

  def down
    change_column :schools, :name, :text
  end
end
