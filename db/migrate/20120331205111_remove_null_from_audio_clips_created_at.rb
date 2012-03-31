class RemoveNullFromAudioClipsCreatedAt < ActiveRecord::Migration
  def up
    change_column :audio_clips, :created_at, :timestamp, :null => true
    change_column :audio_clips, :updated_at, :timestamp, :null => true
  end

  def down
    change_column :audio_clips, :created_at, :datetime, :null => false
    change_column :audio_clips, :updated_at, :datetime, :null => false
  end
end
