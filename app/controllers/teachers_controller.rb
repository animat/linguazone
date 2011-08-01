class TeachersController < ApplicationController
  filter_access_to :index, :update, :destroy
  before_filter :check_expired
  
  def getting_started
    session[:teacher] = nil
    session[:school] = nil
    session[:subscription] = nil
    flash[:notice] = nil
    flash[:error] = nil
    @course = Course.new
    @game = Game.find(10763)
  end
  
  def login
    @user_session = UserSession.new
  end
  
  # GET /teachers
  # GET /teachers.xml
  def index
    @user = current_user
    @news_items = News.all(:limit => 4, :order => "created_at DESC")
    @subscription = Subscription.new
    
    if current_user.subscription.subscription_plan.max_teachers == -1
      @add_teachers_upgrades = nil
    else
      @add_teachers_upgrades = SubscriptionPlan.all(:conditions => ["name = ? AND (max_teachers > ? OR max_teachers = -1)", current_user.subscription.subscription_plan.name, current_user.subscription.subscription_plan.max_teachers])
    end
    if current_user.subscription.subscription_plan.name == "premium"
      @new_plan_upgrades = nil
    else
      if current_user.subscription.subscription_plan.max_teachers == -1
        @new_plan_upgrades = SubscriptionPlan.all(:conditions => ["name = 'premium' AND max_teachers = -1"])
      else
        @new_plan_upgrades = SubscriptionPlan.all(:conditions => ["name = 'premium' AND (max_teachers >= ? OR max_teachers = -1)", current_user.subscription.subscription_plan.max_teachers])
      end
    end
    if current_user.subscription.subscription_plan.name == "trial"
      @basic_subscriptions = SubscriptionPlan.all(:conditions => ["name = 'basic'"], :order => "name, cost")
      @premium_subscriptions = SubscriptionPlan.all(:conditions => ["name = 'premium'"], :order => "name, cost")
    end
  end

  # GET /teachers/new
  # GET /teachers/new.xml
  def new
    if session[:subscription].nil?
      redirect_to :controller => "about", :action => "pricing"
    elsif session[:school].nil?
      redirect_to :controller => "schools", :action => "check"
    end
    @subscription = session[:subscription]
    @school = session[:school]
    @new_teacher = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teacher }
    end
  end

  # POST /teachers
  # POST /teachers.xml
  def create
    if session[:subscription].nil?
      redirect_to :controller => "about", :action => "pricing"
    elsif session[:school].nil?
      redirect_to :controller => "schools", :action => "check"
    end
    @subscription = session[:subscription]
    @school = session[:school]
    
    @new_teacher = User.new(params[:user])
    
    if params[:user][:first_name].blank? or params[:user][:last_name].blank? or params[:user][:email].blank? or params[:user][:password].blank?
      flash[:error] = "Please fill out all of the fields before continuing."
      render :action => "new"
    else
      # unless User.is_valid_email_domain(params[:user][:email])
      #         flash[:error] = "Please make sure you have entered a valid email address."
      #         render :action => "new"
      #       end
      if User.is_email_in_use(params[:user][:email])
        flash[:error] = "That email address is already in our database.<br />Please get in touch if you'd like help reactivating your account."
        render :action => "new"
      else
        @new_teacher.display_name = @new_teacher.first_name + " " + @new_teacher.last_name
        @new_teacher.role = "teacher"
        session[:teacher] = @new_teacher
        redirect_to :controller => "subscription", :action => "confirm"
      end
    end
  end
  
  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Saved your preferences."
      redirect_to :controller => "teachers", :action => "index"
    else
      @news_items = News.all(:limit => 4, :order => "created_at DESC")
      render :action => 'index'
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.xml
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to(teachers_url) }
      format.xml  { head :ok }
    end
  end
end
