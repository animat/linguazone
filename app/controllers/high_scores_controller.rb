class HighScoresController < ApplicationController
  
  def show
    @scores = HighScore.find_all_by_game_id(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @scores.to_xml }
    end
  end
  
  def new
    @high_score = HighScore.new
  end
  
  def create
    if params[:high_score]
      @high_score = HighScore.new(params[:high_score])
    elsif params[:score]
      @high_score = HighScore.new
      @high_score.score = params[:score]
      @high_score.user_id = params[:user_id]
      @high_score.game_id = params[:game_id]
    end
    @high_score.submitted_at = Time.now
    @high_score.user_ip_address = request.remote_ip
    if @high_score.save
      render :text => "Your score has been saved and submitted to your teacher."
    else
      render :text => "Could not save score -- was missing some information."
    end
  end
  
end