class PlayController < ApplicationController
  filter_access_to :stats
  
  def index
    
  end
  
  def show
    @game = Game.find(params[:id], :include => [:activity, :updated_by])
    @premium = (@game.updated_by.nil?) ? false : @game.updated_by.is_premium_subscriber?
    @flashvars = "game_id="+String(@game.id)+"&fullscreen_available="+String(@premium)+"&path=../&isFullscreen=false"
    unless current_user.nil?
      if current_user.role == "student"
        @flashvars += "&user_id="+String(current_user.id)
      end
    end
  end
  
  def stats
    @game = Game.find(params[:id], :include => :activity)
    @course = Course.find(params[:course])
    
    if @game.updated_by_id == current_user.id
      if params[:sort].nil?
        @scores = HighScore.find_all_by_game_id(params[:id])
        @registrations = CourseRegistration.all(:conditions => ["course_id = ?", @course.id])
      else
        if params[:sort] == "name"
          @scores = HighScore.all(:conditions => ["game_id = ?", params[:id]], :order => "user_id")
        elsif params[:sort] == "date"

        elsif params[:sort] == "score"

        end
      end
    else
      redirect_to :action => "show", :id => params[:id]
    end
  end
  
  def report_bug
    ContactMailer.report_bug(params).deliver
    render :text => "Message sent."
  end
end
