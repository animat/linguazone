class Api::V2::FeedItemsController < ApplicationController
  def student
    @student = User.find(params[:id])
    @feed_items = FeedItem.where(:user_id => @student.id).order("created_at desc").page(params[:page]).per(100)
    render json: @feed_items
  end
end