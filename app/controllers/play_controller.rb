class PlayController < ApplicationController
  filter_access_to :stats
  
  def index
    
  end
  
  def show
    if Rails.env.production?
      @game_src = "http://linguazone.s3.amazonaws.com/games"
    else
      @game_src = "http://lz-staging.s3.amazonaws.com/games"
    end
    @ag = AvailableGame.find(params[:id])
    @game = Game.find(@ag.game_id, :include => [:activity, :updated_by])
    @premium = (@game.updated_by.nil?) ? false : @game.updated_by.is_premium_subscriber?
    @flashvars = "game_id="+String(@ag.id)+"&fullscreen_available="+String(@premium)+"&path=../&isFullscreen=false"
    if current_user.nil?
      @uid = 0
    else
      @uid = current_user.id
      if current_user.role == "student"
        @flashvars += "&user_id="+String(current_user.id)
      end
    end
  end
  
  def stats
    @ag = AvailableGame.find(params[:id])
    @game = Game.find(@ag.game_id, :include => :activity)
    @course = Course.find(@ag.course_id)
    
    if @game.updated_by_id == current_user.id
      if params[:sort].nil?
        @scores = HighScore.find_all_by_available_game_id(params[:id])
        @registrations = CourseRegistration.where(:course_id => @course.id).includes(:user).order("users.last_name, users.first_name")
      else
        if params[:sort] == "name"
          @scores = HighScore.all(:conditions => ["available_game_id = ?", params[:id]], :order => "user_id")
        elsif params[:sort] == "date"

        elsif params[:sort] == "score"

        end
      end
    else
      flash[:error] = "You do not have permissions to view that page."
      redirect_to :back
    end
  end
  
  def report_bug
    ContactMailer.report_bug(params).deliver
    render :text => "Message sent."
  end
end
