# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user, :is_teacher_for, :is_student_for, :record_feed_item
  before_filter :set_current_user, :get_teacher_courses, :force_www, :check_for_single_access_token
  
  protected
    # TODO: Cache the teacher's courses so that this query doesn't happen on every page
    # =>        Are there other places that database connections can be minimized? How to approach that?
    def get_teacher_courses
      unless current_user.nil?
        @courses = Course.all(:conditions => ["user_id = ?", current_user.id], :order => "name asc") if current_user.role == "teacher"
      end
    end

    def set_current_user
     Authorization.current_user = current_user
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def check_for_single_access_token
      if params[:user_credentials]
        @current_user = User.find_by_single_access_token(params[:user_credentials])
        @current_user_session = UserSession.create!(@current_user)
        @current_user.reset_single_access_token!
      end
    end
    
    def record_feed_item(c_id, src)
      if current_user
        @fi = FeedItem.new
        @fi.user_id = current_user.id
        @fi.course_id = c_id unless c_id.nil?
        @fi.browser = request.env['HTTP_USER_AGENT']
        @fi.ip_address = request.env['REMOTE_ADDR']
        @fi.controller = controller_name 
        @fi.action = action_name
        @fi.params = params.inspect
        @fi.sourceable = src
        @fi.save
      end
    end

    def is_teacher_for(course)
      return false if current_user.nil? or course.nil?
      return course.user_id == current_user.id
    end

    def is_teacher_for_student(student_id)
      @course_registrations = CourseRegistration.all(:conditions => ["user_id = ?", student_id])
      @val = false
      @course_registrations.each do |cr|
        if is_teacher_for(cr.course)
          @val = true
        end
      end
      @val
    end

    def is_student_for(course)
      return false if current_user.nil?
      return CourseRegistration.all(:conditions => ["user_id = ? AND course_id = ?", current_user.id, course.id]).length > 0
    end

    def check_expired
      unless current_user.nil?
        if current_user.role == "teacher"
          if current_user.subscription.is_expired?
            redirect_to :controller => "subscription", :action => "renew" and return
          end
        end
      else
        redirect_to login_teachers_path
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or(path)
      redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to path
    end
    
    def missing_params
      render json: { message: "Please make sure to complete all required fields." }, status: 400
    end

    def invalid_credentials
      render json: { message: "There was a problem with your username or password." }, status: 401
    end
    
    def force_www
      if Rails.env.production? and request.host[0..3] != "www."
        redirect_to "#{request.protocol}www.#{request.host_with_port}#{request.fullpath}", :status => 301
      end
    end
    
    def permission_denied
      flash[:error] = "You do not have permission to access that page. You may need to login first."
      redirect_to root_url
    end
    
    def permission_denied_api
      render json: { message: "You do not have access to that information." }, status: 401
    end
end
