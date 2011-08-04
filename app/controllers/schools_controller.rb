class SchoolsController < ApplicationController
  auto_complete_for :school, :name

  def index
    redirect_to :controller => "students", :action => "login"
  end

  def show
    @school = School.find(params[:id])
    @courses = Course.find_courses_at_school(@school)
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @school }
    end
  end

  def search
    @schools = School.all(:conditions => ['LOWER(name) LIKE ?', '%'+params[:school][:name]+'%'])
    if @schools.length == 1
      redirect_to @schools
    elsif @schools.length == 0
      @states = State.all(:conditions => ["intl = 0"], :order => "name")
      @intl_states = State.all(:conditions => ["intl = 1"], :order => "name")
    end
  end

  def check
    if params[:trial] != nil
      @subscription = Subscription.new
      @subscription.subscription_plan = SubscriptionPlan.find(9);
    elsif params[:subscription] != nil
      @subscription = Subscription.new(params[:subscription])
    else
      redirect_to :controller => "about", :action => "pricing"
    end
    session[:subscription] = @subscription
  end

  def confirm_or_new
    if session[:subscription].nil?
      redirect_to :controller => "about", :action => "pricing"
    else
      @similar_schools = School.all(:conditions => ['LOWER(name) LIKE ?', '%'+params[:school][:name]+'%'])
      if @similar_schools.length == 1
        @school = @similar_schools[0]
        if @school.subscription.nil?
          session[:school] = @school
          redirect_to :controller => "teachers", :action => "new"
        else
          if @school.subscription.is_expired?
            session[:school] = @school
            redirect_to :controller => "teachers", :action => "new"
          else
            if @school.subscription.subscription_plan.name == "trial"
              session[:school] = @school
              redirect_to :controller => "teachers", :action => "new"
            else
              flash[:error] = @school.name+" already has an account.<br />Please enter the school's 5-digit pin number below in order to proceed."
              redirect_to :controller => "about", :action => "pricing"
            end
          end
        end

      else
        redirect_to :action => "new", :school_name => params[:school][:name]
      end
    end
  end

  def new
    if session[:subscription].nil?
      redirect_to :controller => "about", :action => "pricing"
    else
      @subscription = session[:subscription]
      @school = School.new(:name => params[:school_name].titleize)
      @states = State.all(:conditions => ["intl = 0"], :order => "name").collect { |state| [state.name, state.id]}
      @intl_states = State.all(:conditions => ["intl = 1"], :order => "name").collect { |state| [state.name, state.id]}
    end
  end

  def create
    @school = School.new(params[:school])
    if @school.save
      session[:school] = @school
      redirect_to :controller => "teachers", :action => "new"
    else
      @states = State.all(:conditions => ["intl = 0"], :order => "name").collect { |state| [state.name, state.id]}
      @intl_states = State.all(:conditions => ["intl = 1"], :order => "name").collect { |state| [state.name, state.id]}
      render :action => "new"
    end
  end

end
