class SetGameToUseTextInsteadOfString < ActiveRecord::Migration
  def up
  end

  def down
    change_column :games, :audio_ids, :string
    change_column :games, :description, :string
  end
end
