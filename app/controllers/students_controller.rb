class StudentsController < ApplicationController
  filter_access_to :index, :register, :search_for_school, :select_school, :enter_code, :auto_complete_for_school
  autocomplete :school, :name

  def index
    @registered_courses = CourseRegistration.all(:conditions => ["user_id = ?", current_user.id], :include => :course)
  end

  def show
    if current_user.nil?   # Must be logged in
      @proceed = false
    else
      if String(current_user.id) == String(params[:id])   # Students can see their own stats
        @proceed = true
      else
        if is_teacher_for_student(params[:id]) || current_user.id == 30   # Teachers can see their students stats (and info@linguazone.com)
          @proceed = true
        else
          @proceed = false
        end
      end
    end
    if @proceed
      @student = User.find(params[:id])
      @high_scores = HighScore.all(:conditions => ["user_id = ?", params[:id]], :order => "submitted_at DESC")
    else
      redirect_to :controller => "my_courses"
    end
  end

  def login
    @user_session = UserSession.new
    @states =      State.national
    @intl_states = State.international
  end

  def register
    @school = School.new
  end

  def find_school
    @similar_schools = School.all(:conditions => ['LOWER(name) LIKE ?', params[:school][:name]])
    if @similar_schools.length == 1
      @school = @similar_schools[0]
      @courses = Course.find_courses_at_school(@school)
      @registration = CourseRegistration.new
      render :update do |page|
        page.replace 'select_course', :partial => "select_course"
      end
    else
      render :update do |page|
        page.replace 'search_for_school', '<div id="search_for_school">Could not locate your school. Sorry!</div>'
        page.visual_effect :highlight, 'search_for_school'
      end
    end
  end

  def select_course
    @course = Course.find(params[:course_registration][:course_id])
    @registration = CourseRegistration.new(params[:course_registration])
    @registration.user_id = current_user.id
    if @course.login_required == false
      @registration.save
    end
    render :update do |page|
      page.replace 'select_course', '<div id="select_course">'+@course.name+' taught by '+@course.user.display_name+'</div>'
      page.visual_effect :highlight, 'select_course'
      if @course.login_required == true
        page.replace 'enter_code', :partial => "enter_code"
      else
        page.replace 'enter_code', '<div id="enter_code"><p>No class code needed! You are all set. '+
                      (link_to "Visit the "+ @course.name+" class page", :controller => "courses", :action => "show", :id => @course.id) +
                      ' and get started now.</p></div>'
      end
    end
  end

  def enter_code
    @course = Course.find(params[:course_id])
    @success = @course.code.downcase == params[:code].downcase

    if @success == true
      @registration = CourseRegistration.new({:course_id => params[:course_id], :user_id => current_user.id})
      @registration.save
    end

    render :update do |page|
      if @success == true
        page.replace 'enter_code', '<div id="enter_code"></div>'
        page.replace 'confirm_code', '<div id="confirm_code"><p>Great! You are all set. '+
                      (link_to "Visit the "+ @course.name+" class page", :controller => "courses", :action => "show", :id => @course.id) +
                      ' and get started now.</p></div>'
        page.visual_effect :highlight, 'confirm_code'
      else
        page.replace 'confirm_code', '<div id="confirm_code"><p>That code was incorrect. Please try again.</p></div>'
        page.visual_effect :highlight, 'confirm_code'
      end
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    @user.first_name.titleize
    @user.last_name.titleize
    @user.role = "student"
    @user.school_id = 0
    @user.discount_id = 0
    @user.receive_newsletter = 0
    @user.default_language_id = 0
    
    respond_to do |format|
      if User.is_email_in_use(@user.email) 
        flash[:error] = "That username or email address is already in the database."
      else
        if @user.save
          format.html { redirect_to :controller => "students", :action => "index" }
        else
          flash[:error] = "There was an error creating your account."
          format.html { render :action => "new" }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    #@cr = CourseRegistration.all(:)

    @user.destroy
    redirect_to :controller => "my_courses", :action => "index"
  end

  def permission_denied
    redirect_to :action => "login"
  end

end
