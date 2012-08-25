class AboutController < ApplicationController
  
  def index
    if session[:school] != nil
      session[:school] = nil
    end
    if session[:subscription] != nil
      session[:subscription] = nil
    end
    if session[:teacher] != nil
      session[:teacher] = nil
    end
  end

  def features
  end
  
  def games
    @activities = Activity.all(:order => "name")
  end
  
  def word_lists
    @convertable_activities = Activity.where(:convertable => true)
  end
  
  def audio_blogs
  end
  
  def tracking
  end
  
  def pricing
    @subscription = Subscription.new
    session[:subscription] = nil
    session[:school] = nil
    session[:teacher] = nil
  end
  
  def languages
    @languages = Language.all(:order => "name")
  end
  
  def demos
    if params[:language].nil?
      redirect_to :action => "languages"
    else
      @language = Language.find(params[:language].to_i)
      @demos = Demo.all(:conditions => ["language_id = ? and category != 'general'", @language.id], :include => "activity", :order => "activities.name")
    end
  end
  
  def play_demo
    @raw_game = Game.find(params[:id], :include => :activity)
    @game = AvailableGame.where(:game_id => @raw_game.id, :course_id => 0).first
    @flashvars = "game_id="+String(@game.id)+"&fullscreen_available=true&path=../../../&isFullscreen=false"
  end
  
  def us
  end
  
  def send_mail
    ContactMailer.contact_email(params[:email]).deliver
    flash[:success] = "Your message has been sent. Expect a reply shortly."
    redirect_to :action => "us"
  end
  
end
