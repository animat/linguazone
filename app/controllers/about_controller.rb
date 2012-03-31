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
    @convertable_activities = Activity.all(:conditions => "convertable = 1")
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
  
  def us
  end
  
  def send_mail
    ContactMailer.deliver_contact_email(params[:email])
    flash[:notice] = "Your message has been sent. Expect a reply shortly."
    redirect_to :action => "us"
  end
  
end
