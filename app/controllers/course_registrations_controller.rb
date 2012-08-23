class CourseRegistrationsController < ApplicationController
  respond_to :html
  
  def index
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @regs = CourseRegistration.where(:course_id => params[:course_id]).joins(:user).order("users.last_name")
    else
      flash[:notice] = "Please view class enrollments from a class page."
      redirect_to teachers_path
    end
  end
  
  def destroy
    @cr = CourseRegistration.find(params[:id])
    @cr.destroy
    redirect_to :back
  end
end