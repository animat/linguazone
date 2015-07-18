class  Api::V2::CommentsController < ApplicationController
  def create
    @comment = Comment.new(user_id: params[:userId], audio_id: params[:audioId], content: params[:content], available_post_id: params[:availablePostId])
    
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"]) || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    # TODO: This header is not being intercepted by Angular properly... must be included in data response as "token"
    response.headers["X-AUTH-TOKEN"] = @user.single_access_token
    
    if @comment.save
      if params[:audioId].to_i != 0 # Save an audio clip and move it on S3
        @path = params[:audioId]
        @ext = "mp3"
        # TODO: Store relevant metadata along with the audio clip info
        @new_audio_clip = AudioClip.create(user_id: params[:userId])
        @comment.audio_id = @new_audio_clip.id
        @comment.save
      
        #cred = YAML.load(File.open("#{Rails.root}/config/s3.yml")).symbolize_keys!
        #AWS::S3::Base.establish_connection! cred
        s3 = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
        bucket = s3.buckets[ENV['S3_BUCKET_NAME']]
      
        key = "transloadit/#{@path}.#{@ext}"
        obj = bucket.objects[key]
      
        # TODO: Confirm that newer aws-sdk does not need to loop through truncated results
        #while obj.nil? and bucket.is_truncated
        #  bucket = AWS::S3::Bucket.find("linguazone", :prefix => "transloadit", :marker => lz.objects.last.key)
        #  obj = bucket[key]
        #end
        if obj.nil?
          flash[:error] = "There was an error recording your audio. Please try again."
          redirect_to(@comment.available_post)
        else
          # Only move into audio folder if in production environment. Otherwise simply rename.
          if Rails.env.production?
            obj.move_to("audio/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
          else
            obj.move_to("transloadit/#{@new_audio_clip.id}.#{@ext}", :acl => :public_read)
          end
  
          record_feed_item(@comment.available_post.course.id, @comment)
          
          render json: { token: @user.single_access_token, message: "Your comment has been created"}
        end
      else # No audio on this comment; just update metadata on the save.
        record_feed_item(@comment.available_post.course.id, @comment)
        render json: { token: @user.single_access_token, message: "Your comment has been created" }
        
      end
    else # Comment could not save
      render json: { token: @user.single_access_token, message: "Error while saving your comment" }, status: 400
    end
  end