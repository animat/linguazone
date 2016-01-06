class RemovePinFromSchools < ActiveRecord::Migration
  def up
    remove_column :schools, :pin
  end

  def down
    add_column :school, :pin, :integer
  end
end
