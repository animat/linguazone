class MyCoursesController < ApplicationController
  before_filter :check_expired
  
  def index
    @courses = Course.all(:conditions => ["user_id = ?", current_user.id], :include => :course_registrations)
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(params[:course])
    
    if @course.login_required?
      if @course.code.blank?
        @course.login_required = false
      end
    end
    
    respond_to do |format|
      if @course.save
        format.html {redirect_to :controller => "courses", :action => "show", :id => @course.id}
        format.js {render :text => "Your class has been saved. Next, customize a game below."}
      else
        format.html {render :action => "new"}
        format.js {render :text => "Oops! There was an error creating your class. Try again from the Classes link at the top of the page."}
      end
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    @course = Course.find(params[:id])
    if @course.user_id == current_user.id  
      @course.destroy
    
      flash[:notice] = "The class has been deleted."
      redirect_to :action => "index"
    else
      flash[:error] = "You do not have access to that class."
      redirect_to :action => "index"
    end
  end
end
