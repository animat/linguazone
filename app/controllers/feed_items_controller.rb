class FeedItemsController < ApplicationController
  def index
    if params[:student_id]
      @student = User.find(params[:student_id])
      @feed_items = FeedItem.where(:user_id => @student.id).order("created_at desc").page(params[:page]).per(100)
      @usage = @student.display_name
      @show_user_name = false
    elsif params[:course_registration_id]
      @cr = CourseRegistration.find(params[:course_registration_id])
      @course = Course.find(@cr.course_id)
      @student = User.find(@cr.user_id)
      @feed_items = FeedItem.where(:user_id => @student.id, :course_id => @course.id).order("created_at desc").page(params[:page]).per(100)
      @usage = "#{@student.display_name} in #{@course.name}"
      @show_user_name = false
    elsif params[:course_id]
      @course = Course.find(params[:course_id])
      @feed_items = FeedItem.where(:course_id => @course.id).includes(:user).where("users.role = 'student'").order("feed_items.created_at desc").page(params[:page]).per(100)
      @usage = @course.name
      @show_user_name = true
    else
      flash[:notice] = "You do not have permission to view that activity stream."
      redirect_to :back
    end
  end
end
