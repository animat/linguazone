class SetGameToUseTextInsteadOfString < ActiveRecord::Migration
  def up
    change_column :games, :audio_ids, :text
    change_column :games, :description, :text
  end

  def down
    change_column :games, :audio_ids, :string
    change_column :games, :description, :string
  end
end
