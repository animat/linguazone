class AddIndexToExample < ActiveRecord::Migration
  def change
    add_column :examples, :question_name, :string
    add_index :examples, :language_id
    add_index :examples, :activity_id
    add_index :examples, :default
  end
end
