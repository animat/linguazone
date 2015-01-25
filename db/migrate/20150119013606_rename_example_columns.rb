class RenameExampleColumns < ActiveRecord::Migration
  def change
    rename_column :examples, :question_name, :node_key_name
    rename_column :examples, :node_input,    :node_value
    rename_column :examples, :display_label, :input_description
  end
end
