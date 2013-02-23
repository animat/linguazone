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
  
  def gradebook
    @course = Course.find(params[:course_id])
    @users = @course.course_registrations.includes("user").order("users.last_name").map {|r| r.user}
    
    @showing_posts = AvailablePost.showing.on_course(@course.id).includes(:post).order("posts.updated_at DESC")
    @comments = @showing_posts.all.map{|p| p.comments.to_a}.flatten
    
    @showing_word_lists = AvailableWordList.showing.on_course(@course.id).includes(:word_list).order("word_lists.updated_at DESC")
    @study_histories = @showing_word_lists.all.map{|wl| wl.study_histories.to_a}.flatten
    
    @showing_games = AvailableGame.showing.on_course(@course.id).includes({:game => :activity}).order("ordering ASC, games.updated_at DESC")
    @high_scores = @showing_games.all.map{|g| g.high_scores.to_a}.flatten
    
    @activities = @showing_posts.all + @showing_word_lists.all + @showing_games.all
  end
end
