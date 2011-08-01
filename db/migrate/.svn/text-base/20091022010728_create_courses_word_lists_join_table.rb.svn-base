class CreateCoursesWordListsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :available_word_lists, :id => :false do |t|
      t.integer :course_id
      t.integer :word_list_id
      t.integer :teacher_id
    end
  end

  def self.down
    remove_table :available_word_lists
  end
end
