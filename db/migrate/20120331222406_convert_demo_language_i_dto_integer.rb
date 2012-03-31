class ConvertDemoLanguageIDtoInteger < ActiveRecord::Migration
  def up
    change_column :demos, :language_id, :integer
    change_column :demos, :activity_id, :integer
  end

  def down
    change_column :demos, :language_id, :string
    change_column :demos, :activity_id, :string
  end
end
