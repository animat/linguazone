class MyPostsController < CourseItemsController

  def index
    unless current_user.is_premium_subscriber?
      redirect_to :controller => "posts", :action => "upgrade_reminder"
    end
    @search = joining_table.search(params[:search])
    @search_type = "default"
    @ap = AvailablePost.includes(:post).where(:user_id => current_user.id).order("posts.updated_at DESC").page(params[:page])
    @total_posts = AvailablePost.where(user_id: current_user.id).count
  end
  
  def joining_table
    AvailablePost
  end
  
  def destroy
    @ap = AvailablePost.find(params[:id])
    if @ap.post.user_id == current_user.id
      @ap.post.destroy
      
      @ap.destroy
    
      flash[:notice] = "The post has been deleted."
      redirect_to my_posts_path
    else
      flash[:error] = "You do not have access to that audio blog post."
      redirect_to my_posts_path
    end
  end
  
end
