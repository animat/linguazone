class AddIndexToExample < ActiveRecord::Migration
  def change
    add_column :examples, :question_name, :string
    add_column :examples, :input_text, :string
    add_column :node_xml, :text
    add_index :examples, :language_id
    add_index :examples, :activity_id
    add_index :examples, :default
    add_column :examples, :node_xml, :text
  end
end
