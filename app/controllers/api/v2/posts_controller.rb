class Api::V2::PostsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  require 'aws/s3'

  def show
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"]) || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    # TODO: This header is not being intercepted by Angular properly... must be included in data response as "token"
    response.headers["X-AUTH-TOKEN"] = @user.single_access_token
    
    @ap = AvailablePost.includes({:comments => :user}).find(params[:id])
    
    return permission_denied_api unless @user.is_student_in_course(@ap.course_id)
    
    @post = Post.find(@ap.post_id)
    @course = Course.find(@ap.course_id)
    render json: {token: @user.single_access_token, post: @post, comments: @ap.comments.to_json(:include => {:user => {:only => :display_name}})}
  end
end
