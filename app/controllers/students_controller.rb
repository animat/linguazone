class StudentsController < ApplicationController
  filter_access_to :register, :search_for_school, :select_school, :enter_code, :auto_complete_for_school
  autocomplete :school, :name
  respond_to :html, :js
  
  def index
    if current_user
      @user = current_user
      @registered_courses = CourseRegistration.all(:conditions => ["user_id = ?", current_user.id], :include => :course)
    else
      redirect_to find_class_students_path
    end
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

  def find_class
    @states =      State.national
    @intl_states = State.international
  end
  
  def login
    @user_session = UserSession.new
  end

  def register
    @school = School.new
  end

  def find_school
    @similar_schools = School.all(:conditions => ['LOWER(name) LIKE ?', params[:school][:name].downcase])
    if @similar_schools.length == 1
      @school = @similar_schools[0]
      @courses = Course.find_courses_at_school(@school)
      @registration = CourseRegistration.new
    end
  end

  def select_course
    @course = Course.find(params[:course_registration][:course_id])
    @registration = CourseRegistration.new(params[:course_registration])
    @registration.user_id = current_user.id
    unless @course.login_required
      if session[:attempting_to_access_course_id]
        session[:attempting_to_access_course_id] = nil
        session.delete :attempting_to_access_course_id
      end
      @registration.save
    end
  end

  def enter_code
    @course = Course.find(params[:course_id])
    if @course.code.downcase == params[:code].downcase
      @registration = CourseRegistration.new({:course_id => params[:course_id], :user_id => current_user.id})
      @registration.save
      if session[:attempting_to_access_course_id]
        session[:attempting_to_access_course_id] = nil
        session.delete :attempting_to_access_course_id
      end
    end
  end
  
  def confirm_course_enter_code
    if session[:attempting_to_access_course_id]
      @course = Course.find(session[:attempting_to_access_course_id])
    else
      redirect_to students_path
    end
  end

  def new
    @user = User.new

    if session['omniauth']
      @user.apply_omniauth(session['omniauth'])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @next_id = User.last.id.to_i + 1
    @user = User.new(params[:user])
    
    if session['omniauth']
      @user.apply_omniauth(session['omniauth'])
    end
    
    @user.first_name.titleize
    @user.last_name.titleize
    @user.role = "student"
    @user.school_id = 0
    @user.discount_id = 0
    @user.receive_newsletter = 0
    @user.default_language_id = 0
    
    if @user.authentications.any?
      if @user.password.blank?
        @user.password = (0..16).to_a.map{|a| rand(16).to_s(16)}.join
      end
      if @user.email.blank?
        @user.email = "lz_student_#{@next_id}@linguazone.com"
      end
    end
    
    respond_to do |format|
      if User.is_email_in_use(@user.email) 
        flash[:error] = "That username or email address (#{@user.email}) is already in the database."
        format.html { render :action => "new" }
      else
        if @user.save
          session['omniauth'] = nil
          session.delete :omniauth
          UserSession.create @user
          if session[:attempting_to_access_course_id]
            format.html { redirect_to confirm_course_enter_code_students_path }
          else
            format.html {redirect_to students_path }
          end
        else
          flash[:error] = "There was an error creating your account."
          format.html { render :action => "new" }
        end
      end
    end
  end
  
  def update
    @user = current_user
    # Pseudo-validations and tweaks for email address changes
    if params[:user][:email]
      if User.is_email_in_use(params[:user][:email])
        flash[:error] = "Sorry! That email address is already in use by another account."
        redirect_to students_path and return
      elsif params[:user][:email].blank?
        @user.email = "lz_student_#{@user.id}@linguazone.com"
        @user.save
        flash[:success] = "Saved your settings."
        redirect_to students_path and return
      end
    end
    
    if @user.update_attributes!(params[:user])
      flash[:success] = "Saved your settings."
    else
      flash[:error] = "Could not save your settings."
      flash[:notice] = @user.errors
    end
    redirect_to students_path
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
