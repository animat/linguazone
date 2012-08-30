class DestroyAllHighScoresAndStudyHistories < ActiveRecord::Migration
  def up
    add_column :high_scores, :available_game_id, :integer
    @scores = HighScore.all
    puts "*"*50
    puts "At first there were #{@scores.count} high scores"
    @scores.each do |s|
      s.destroy
    end
    remove_column :high_scores, :game_id
    @scores = HighScore.all
    puts "And then there were #{@scores.count}"
    
    add_column :comments, :available_post_id, :integer
    @comments = Comment.all
    puts "At first there were #{@comments.count} comments"
    @comments.each do |c|
      c.destroy
    end
    remove_column :comments, :post_id
    @comments = Comment.all
    puts "And then there were #{@comments.count}"
    
    add_column :study_histories, :available_word_list_id, :integer
    @sh = StudyHistory.all
    puts "At first there were #{@sh.count} study histories"
    @sh.each do |s|
      s.destroy
    end
    remove_column :study_histories, :word_list_id
    @sh = StudyHistory.all
    puts "And then there were #{@sh.count}"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
