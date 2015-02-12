class PostsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  require 'aws/s3'
  filter_access_to :index, :new, :create, :edit, :update, :destroy
  
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    @ap = AvailablePost.includes({:comments => :user}).find(params[:id])
    @post = Post.find(@ap.post_id)
    @course = Course.find(@ap.course_id)
    unless current_user.nil?
      @comment = Comment.new( :available_post => @ap )
    
      @student_comments = @ap.comments
      @student_comments = @student_comments.page(params[:page])
      
      if current_user.is_student?
        @solo_comments = @ap.comments.where(:user_id => current_user.id)
        @solo_comments = @solo_comments.page(params[:page])
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

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
    @ap = AvailablePost.find(params[:id])
    @post = @ap.post
  end

  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if params[:post][:audio_id] != 0
        @path = params[:post][:audio_id]
        @ext = "mp3"
                  
        # TODO: Store relevant metadata along with the audio clip info
        @new_audio_clip = AudioClip.create(user: current_user)
        @post.audio_id = @new_audio_clip.id
        
        if @post.save
          s3 = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
          bucket = s3.buckets[ENV['S3_BUCKET_NAME']]
          
          key = "transloadit/#{@path}.#{@ext}"
          obj = bucket.objects[key]
          
          # TODO: Confirm that newer aws-sdk does not need to loop through truncated results
          #while obj.nil? and bucket.is_truncated
          #  bucket = AWS::S3::Bucket.find("linguazone", :prefix => "transloadit", :marker => lz.objects.last.key)
          #  obj = bucket[key]
          #end
          if obj.nil? # Cannot find the recording
            flash[:error] = "There was an error recording your audio. Please try again."
            format.html { render :action => "new" }
          else # Found the recording. Rename, reset permissions, and (only on production) move the file. Save it.
            if Rails.env.production?
              obj.move_to("audio/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
            else
              obj.move_to("transloadit/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
            end
        
            @available_post = AvailablePost.new(:post_id => @post.id, :user_id => @post.user_id, :course_id => @post.course_id, :ordering => 0, :hidden => 0)
            @available_post.save
            flash[:success] = "Your new post has been created and added to the class page"
            format.html { redirect_to post_path(@available_post) }
          end
        else # If save fails...
          flash[:error] = "There has been an error creating your new post"
          format.html { redirect_to :back }
        end
      else
        # Condition for no audio recording, just text
        if @post.save
          @available_post = AvailablePost.new(:post_id => @post.id, :user_id => @post.user_id, :course_id => @post.course_id, :ordering => 0, :hidden => 0)
          @available_post.save
          flash[:success] = "Your new post has been created and added to the class page"
          format.html { redirect_to post_path(@available_post) }
        else
          flash[:error] = "There has been an error creating your new post"
          format.html { redirect_to :back }
        end
      end
      
    end
  end

  def update
    # TODO: Warning -- the id that comes through is for a POST, not for an AvailablePost. 
    @post = Post.find(params[:id])
    @ap = AvailablePost.find_by_course_id_and_post_id(params[:post][:course_id], @post.id)

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:success] = "Your post has been updated"
        format.html { redirect_to post_path(@ap) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ap = AvailablePost.find(params[:id])
    @course_id = @ap.course_id
    @post = @ap.post
    @post.destroy
    
    @available_post = AvailablePost.all(:conditions => ["post_id = ? AND course_id <> 0", @post.id])
    @available_post.each do |ap|
      ap.destroy
    end

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
