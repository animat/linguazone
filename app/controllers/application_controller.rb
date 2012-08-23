# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user, :is_teacher_for, :is_student_for
  before_filter :set_current_user, :get_teacher_courses, :force_www

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

    def is_teacher_for(course)
      return false if current_user.nil?
      return course.user_id == current_user.id
    end

    def is_teacher_for_student(student_id)
      @course_registrations = CourseRegistration.all(:conditions => ["user_id = ?", student_id])
      @val = false
      @course_registrations.each do |cr|
        logger.info "Current user and current course in "+cr.course.name+"... "+String(cr.course.user_id)+" --- "+String(current_user.id)
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
            redirect_to :controller => "subscription", :action => "renew"
          end
        end
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
    
    def force_www
      if Rails.env.production? and request.host[0..3] != "www."
        redirect_to "#{request.protocol}www.#{request.host_with_port}#{request.fullpath}", :status => 301
      end
    end
    
    def permission_denied
      flash[:error] = "You do not have permission to access that page. You may need to login first."
      redirect_to root_url
    end
end
