class MyCoursesController < ApplicationController
  before_filter :check_expired

  def index
    @courses = Course.all(:conditions => ["user_id = ?", current_user.id], :order => "name asc", :include => :course_registrations)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    @course.guid = rand(36**24).to_s(36)
    if @course.login_required?
      if @course.code.blank?
        @course.login_required = false
      end
    end

    respond_to do |format|
      if @course.save
        flash[:success] = "This is your new class page. Students in your "+@course.name+" class will find your games, word lists, and audio blogs here."
        format.html { redirect_to course_path(@course) }
        format.js
      else
        format.html { render :action => "new" }
        format.js { render :text => "Oops! There was an error creating your class. Try again from the Classes link at the top of the page." }
      end
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = "Your class has been updated."
      redirect_to my_courses_path
    else
      flash[:error] = "There was an error updating your class."
      render :action => "edit"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    # TODO: Use cancan for authorization
    if @course.user_id == current_user.id
      @course.destroy

      flash[:notice] = "#{@course.name} has been deleted."
      redirect_to my_courses_path
    else
      flash[:error] = "You do not have access to that class."
      redirect_to my_courses_path
    end
  end
end
