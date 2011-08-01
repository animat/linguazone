class RenameUsersToTeachers < ActiveRecord::Migration
  def self.up
    rename_table :users, :teachers
  end

  def self.down
    rename_table :teachers, :users
  end
end
