class HighScoresController < ApplicationController
  
  def show
    @scores = HighScore.find_all_by_available_game_id(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @scores.to_xml }
    end
  end
  
  def new
    @high_score = HighScore.new
  end
  
  def create
    @existing_games = HighScore.all(:conditions => ["user_id = ? AND available_game_id = ? AND submitted_at >= ?", 
                                                      params[:user_id], params[:game_id], Time.now - 10.seconds]).length
    if @existing_games > 0
      render :text => "Cannot save duplicate score information."
    else
      if params[:high_score]
        @high_score = HighScore.new(params[:high_score])
      elsif params[:score]
        @high_score = HighScore.new
        @high_score.score = params[:score]
        @high_score.user_id = params[:user_id]
        @high_score.available_game_id = params[:game_id]
      else
        @high_score = HighScore.new
        @high_score.score = ""
        @high_score.user_id = params[:user_id]
        @high_score.available_game_id = params[:game_id]
      end
      @high_score.submitted_at = Time.now
      @high_score.user_ip_address = request.remote_ip
      if @high_score.save
        @ag = AvailableGame.find(params[:game_id])
        record_feed_item(@ag.course_id, @high_score)
        render :text => "Your score has been saved and submitted to your teacher."
      else
        render :text => "Could not save score -- was missing some information."
      end
    end
  end
  
end