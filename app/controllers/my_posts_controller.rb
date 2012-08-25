class MyPostsController < CourseItemsController

  def index
    unless current_user.is_premium_subscriber?
      redirect_to :controller => "posts", :action => "upgrade_reminder"
    end
    @ap = AvailablePost.where(:user_id => current_user.id).order("updated_at DESC").page(params[:page])
  end
  
  def joining_table
    AvailablePost
  end
  
end
