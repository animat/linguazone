class AddLabelHintToExample < ActiveRecord::Migration
  def change
    add_column :examples, :display_label, :string
    add_column :examples, :hint, :string
  end
end
