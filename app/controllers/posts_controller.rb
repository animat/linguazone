class PostsController < ApplicationController
  filter_access_to :index, :new, :create, :edit, :update, :destroy
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id], :include => [:course])
    unless current_user.nil?
      @comment = Comment.new( :post => @post )
    
      @student_comments = @post.comments
      @student_comments = @student_comments.page(params[:page])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    if current_user.is_premium_subscriber?
      @course_id = params[:course_id] || 0
      @post = Post.new
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @post }
      end
    else
      redirect_to :action => "upgrade_reminder"
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        
        @available_post = AvailablePost.new(:post_id => @post.id, :user_id => @post.user_id, :course_id => @post.course_id, :ordering => 0, :hidden => 0)
        @available_post.save
        flash[:success] = "Your new post has been created and added to the class page"
        
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        flash[:error] = "There has been an error creating your new post"
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @course_id = @post.course_id
    @post.destroy
    
    @available_post = AvailablePost.all(:conditions => ["post_id = ? AND course_id = ?", @post.id, @post.course_id])
    @available_post[0].destroy

    respond_to do |format|
      format.html { redirect_to :controller => "courses", :action => "show", :id => @course_id }
      format.xml  { head :ok }
    end
  end
  
  def permission_denied
    flash[:error] = "Audio blogs are password-protected. Please login first."
    redirect_to :controller => "students", :action => "login"
  end
  
  def upgrade_reminder
  end
end
