class Api::V1::HighScoresController < ApplicationController
  
  def show
    @high_scores = HighScore.where(:game_id => params[:id])
    @game = Game.find(params[:id])
    respond_to do |format|
      format.xml
    end
  end
  
  def create
    if params[:user_id].nil? or params[:game_id].nil? or params[:score].nil?
      render :text => "Could not save score -- was missing some information."
    else
      @last_entry = HighScore.where(:user_id => params[:user_id], :game_id => params[:game_id]).order(:submitted_at).last
      if Time.now - @last_entry.submitted_at > 10
        @hs = HighScore.new(:user_id => params[:user_id], :game_id => params[:game_id], :score => params[:score],
                :submitted_at => Time.now, :user_ip_address => request.remote_ip)
        if @hs.save
          @ag = AvailableGame.find(params[:game_id])
          record_feed_item(@ag.course_id)
          render :text => "Your score has been saved and submitted to your teacher."
        else
          render :text => "There was an error saving your score to the database."
        end
      else
        render :text => "Could not save score -- duplicate score in database."
      end
    end
  end
    
end
