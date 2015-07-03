class Api::V2::PostsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  require 'aws/s3'
  
  # TODO: Need to enforce authorization on API!
  #filter_access_to :show

  def show
    @ap = AvailablePost.includes({:comments => :user}).find(params[:id])
    @post = Post.find(@ap.post_id)
    @course = Course.find(@ap.course_id)
    unless current_user.nil?
      @comment = Comment.new( :available_post => @ap )
    
      @student_comments = @ap.comments
      @student_comments = @student_comments.page(params[:page])
      
      if current_user.is_student?
        @solo_comments = @ap.comments.where(:user_id => current_user.id)
        @solo_comments = @solo_comments.page(params[:page])
      end
    end
    render json: {post: @post, comments: @student_comments.to_json(:include => {:user => {:only => :display_name}})}
  end
end
