class Api::V2::FeedItemsController < ApplicationController
  def student
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"]) || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    # TODO: This header is not being intercepted by Angular properly... must be included in data response as "token"
    response.headers["X-AUTH-TOKEN"] = @user.single_access_token
    
    @student = User.find(params[:id])
    
    return permission_denied_api unless @student.id == @user.id
    
    @feed_items = FeedItem.where(:user_id => @student.id).order("created_at desc").page(params[:page]).per(100)
    render json: {data: {token: @user.single_access_token, feed_items: @feed_items}}
  end
end