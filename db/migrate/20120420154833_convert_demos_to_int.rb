class ConvertDemosToInt < ActiveRecord::Migration
  def up
    change_column :demos, :language_id, :string
    change_column :demos, :activity_id, :string
  end

  def down
    change_column :demos, :language_id, :string
    change_column :demos, :activity_id, :string
  end
end
