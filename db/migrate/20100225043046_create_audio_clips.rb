class CreateAudioClips < ActiveRecord::Migration
  def self.up
    create_table :audio_clips do |t|
      t.integer :user_id, :used_in_games_tally, :post_id, :comment_id
      t.timestamps
    end
  end

  def self.down
    delete :audio_clips
  end
end
