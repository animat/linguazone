class MyPostsController < ApplicationController
  def search
  end

  def index
    unless current_user.is_premium_subscriber?
      redirect_to :controller => "posts", :action => "upgrade_reminder"
    end
    @all_posts = Post.search(:user_id_equals => current_user.id)
    @posts = @all_posts.all(:order => "updated_at DESC")
    @posts = @posts.paginate(:page => params[:page]) unless @posts.empty?
  end

end
