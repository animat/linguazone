class MyPostsController < ApplicationController
  def search
  end

  def index
    unless current_user.is_premium_subscriber?
      redirect_to :controller => "posts", :action => "upgrade_reminder"
    end
    @posts = Post.search(:user_id_equals => current_user.id).order(:updated_at).page(params[:page])
  end

end
