class FeedItemsController < ApplicationController
  def index
    if params[:student_id]
      @student = User.find(params[:student_id])
      @feed_items = FeedItem.where(:user_id => @student.id)
      @usage = @student.display_name
    elsif params[:course_registration_id]
      @cr = CourseRegistration.find(params[:course_registration_id])
      @course = Course.find(@cr.course_id)
      @student = User.find(@cr.user_id)
      @feed_items = FeedItem.where(:user_id => @student.id, :course_id => @course.id)
      @usage = "#{@student.display_name} in #{@course.name}"
    elsif params[:course_id]
      @course = Course.find(params[:course_id])
      @feed_items = FeedItem.where(:course_id => @course.id)
      @usage = @course.name
    else
      flash[:notice] = "You do not have permission to view that activity stream."
      redirect_to :back
    end
  end
end
