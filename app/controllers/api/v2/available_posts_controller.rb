class  Api::V2::AvailablePostsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @aps = @course.available_posts.include(:post).where(hidden: false).order(:ordering)
    render json: @aps
  end
  def show
    @post = AvailablePost.find(params[:id])
    render json: @post
  end
end

