class CreateCourseRegistrations < ActiveRecord::Migration
  def self.up
    create_table :course_registrations do |t|
      t.references :user, :course
      t.timestamps
    end
    
  end

  def self.down
    remove_table course_registrations
  end
end
