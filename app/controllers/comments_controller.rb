class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      if params[:transloadit]
        params[:transloadit] = JSON.parse(params[:transloadit])
        if params[:transloadit][:ok] == "ASSEMBLY_COMPLETED"
          @path = params[:transloadit][:results][:mp3].first[:id]
          @ext = params[:transloadit][:results][:mp3].first[:ext]
          # TODO: Store relevant metadata along with the audio clip info
          @new_audio_clip = AudioClip.create(user: current_user)
          @comment.audio_id = @new_audio_clip.id
          @comment.save
          
          cred = YAML.load(File.open("#{Rails.root}/config/s3.yml")).symbolize_keys!
          AWS::S3::Base.establish_connection! cred
          bucket = AWS::S3::Bucket.find('linguazone', :prefix => "transloadit")
          key = "transloadit/#{@path}.#{@ext}"
          obj = bucket[key]
          while obj.nil? and bucket.is_truncated
            bucket = AWS::S3::Bucket.find("linguazone", :prefix => "transloadit", :marker => lz.objects.last.key)
            obj = bucket[key]
          end
          if obj.nil?
            flash[:error] = "There was an error recording your audio. Please try again."
            redirect_to(@comment.available_post)
          else
            # Only move into audio folder if in production environment. Otherwise simply rename.
            if Rails.env.production?
              obj.rename("audio/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
            else
              obj.rename("transloadit/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
            end
      
            flash[:success] = "Your comment has been created"
            record_feed_item(@comment.available_post.course.id, @comment)
            redirect_to post_path(@comment.available_post)
          end
        else
          flash[:error] = "There was an error recording your audio. Please try again."
          redirect_to(@comment.available_post)
        end
      else
        flash[:success] = "Your comment has been created"
        record_feed_item(@comment.available_post.course.id, @comment)
        redirect_to post_path(@comment.available_post)
      end
    else
      flash[:error] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.available_post)
    end
  end
  
  def update
    @comment = Comment.find(params[:comment_id])
    
    if params[:teacher_note].empty?
      @comment.update_column(:teacher_note, "")
    else
      @comment.update_column(:teacher_note, params[:teacher_note])
    end
    
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def set_rating
    @comment = Comment.find(params[:comment_id])
    if current_user
      if @comment.available_post.user_id == current_user.id
        @comment.update_column(:rating, params[:rating].to_i)
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end