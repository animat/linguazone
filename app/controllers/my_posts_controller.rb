class MyPostsController < CourseItemsController

  def index
    unless current_user.is_premium_subscriber?
      redirect_to :controller => "posts", :action => "upgrade_reminder"
    end
    @posts = Post.search(:user_id_equals => current_user.id).order("updated_at DESC").page(params[:page])
  end
  
  def joining_table
    AvailablePost
  end
  
end
