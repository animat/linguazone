class Api::V2::PostsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  require 'aws/s3'
  
  # TODO: Need to enforce authorization on API!
  #filter_access_to :show

  def show
    @ap = AvailablePost.includes({:comments => :user}).find(params[:id])
    @post = Post.find(@ap.post_id)
    @course = Course.find(@ap.course_id)
    render json: {post: @post, comments: @ap.comments.to_json(:include => {:user => {:only => :display_name}})}
  end
end
