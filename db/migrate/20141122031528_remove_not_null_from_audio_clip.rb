class RemoveNotNullFromAudioClip < ActiveRecord::Migration
  def change
    change_column :audio_clips, :used_in_games_tally, :integer, :null => true
    change_column :audio_clips, :post_id, :integer, :null => true
    change_column :audio_clips, :comment_id, :integer, :null => true
  end
end
