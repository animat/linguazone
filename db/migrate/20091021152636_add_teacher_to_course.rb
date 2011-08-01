class AddTeacherToCourse < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.references :teachers
    end
  end

  def self.down
  end
end
