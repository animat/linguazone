class SchoolsController < ApplicationController

  def autocomplete_name
    @results = School.all(:conditions => ["LOWER(name) LIKE ?", "%#{params[:term].downcase}%"])
    @results = @results.collect {|match| {"id" => match["id"], "label" => match["name"], "value" => match["name"] } }
    render :json => @results
  end
  
  def index
    redirect_to find_class_students_path
  end

  def show
    @school = School.find(params[:id])
    @list_courses = Course.find_active_courses_at_school(@school)
    @sorting = (params[:sorting] == "true" and current_user.school.id == @school.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @school }
    end
  end
  
  def update_course_order
    params[:course].each_index do |i|
      c = Course.find(params[:course][i])
      c.ordering = i + 1
      c.save
    end
    render :nothing => true
  end

  def search
    if params[:school].nil?
      @states      = State.national
      @intl_states = State.international
      @schools = []
    else
      @schools = School.all(:conditions => ['LOWER(name) LIKE ?', "%#{params[:school][:name].downcase}%"], :order => "name asc")
      if @schools.length == 1
        redirect_to @schools
      else
        @states      = State.national
        @intl_states = State.international
        if @schools.empty?
          flash[:notice] = "Sorry! We couldn't find any schools with that name. Use the links below to locate your school instead."
        end
      end
    end
  end

  def check
    @school = School.new
    if params[:trial] != nil
      @subscription = Subscription.new(:subscription_plan => SubscriptionPlan.trial)
    elsif params[:subscription] != nil
      @subscription = Subscription.new(params[:subscription])
    else
      redirect_to :controller => "about", :action => "pricing"
    end
    session[:subscription] = @subscription
  end

  # TODO: What if there are multiple schools whose names are like the queried name?
  def confirm_or_new
    if session[:subscription].nil?
      redirect_to :controller => "about", :action => "pricing"
    else
      @similar_schools = School.all(:conditions => ['LOWER(name) LIKE ?', "%#{params[:school][:name].downcase}%"])
      if @similar_schools.length > 0
        @school = @similar_schools[0]
        if @school.subscription.nil?
          session[:school] = @school
          redirect_to :controller => "teachers", :action => "new"
        else
          if @school.subscription.is_expired?
            session[:school] = @school
            redirect_to :controller => "teachers", :action => "new"
          else
            if @school.subscription.trial?
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
    if session[:subscription].nil? or params[:school_name].nil?
      redirect_to pricing_path
    else
      @subscription = session[:subscription]
      @school = School.new(:name => params[:school_name].titleize)
      @states      = State.national.collect { |state| [state.name, state.id]}
      @intl_states = State.international.collect { |state| [state.name, state.id]}
      @grouped_state_options = {"International" => @intl_states, " United States" => @states}
    end
  end

  def create
    @school = School.new(params[:school])
    if @school.save
      session[:school] = @school
      redirect_to :controller => "teachers", :action => "new"
    else
      @states      = State.national
      @intl_states = State.international
      render :action => "new"
    end
  end

end
