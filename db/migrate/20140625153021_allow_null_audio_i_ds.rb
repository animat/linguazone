class AllowNullAudioIDs < ActiveRecord::Migration
  def up
  	change_column :games, :audio_ids, :text, :null => true
  end

  def down
  	change_column :games, :audio_ids, :text, :null => false
  end
end
