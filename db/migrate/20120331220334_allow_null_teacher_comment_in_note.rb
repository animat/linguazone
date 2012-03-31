class AllowNullTeacherCommentInNote < ActiveRecord::Migration
  def up
    change_column :comments, :teacher_note, :text, :null => true
  end

  def down
    change_column :comments, :teacher_note, :text, :null => false
  end
end
