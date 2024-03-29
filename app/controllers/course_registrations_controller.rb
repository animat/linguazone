class CourseRegistrationsController < ApplicationController
  respond_to :html
  
  def index
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @regs = CourseRegistration.students_in_course(params[:course_id]).includes({:user => :authentications}).order("users.last_name ASC")
    else
      flash[:notice] = "Please view class enrollments from a class page."
      redirect_to teachers_path
    end
  end
  
  def new
    if params[:course_id]
      @course = Course.find(params[:course_id])
    else
      flash[:notice] = "Please view class enrollments from a class page."
      redirect_to teachers_path
    end
  end
  
  def destroy
    @cr = CourseRegistration.find(params[:id])
    @course = Course.find(params[:course_id])
    @cr.destroy
    flash[:notice] = "That student has been removed from #{@course.name}"
    redirect_to course_course_registrations_path(@course)
  end
end