class CommentsController < ApplicationController
  respond_to :html, :js
  
  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      record_feed_item(@comment.available_post.course.id, @comment)
      redirect_to post_path(@comment.available_post)
    else
      flash[:error] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.post)
    end
  end
  
  def update
    @comment = Comment.find(params[:comment_id])
    
    if params[:teacher_note].empty?
      @comment.teacher_note = ""
    else
      @comment.teacher_note = params[:teacher_note]
    end
    
    @comment.save
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end