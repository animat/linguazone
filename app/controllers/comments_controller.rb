class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])

    if @comment.save 
      redirect_to(@comment.post)
    else
      flash[:error] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.post)
    end
  end
  
  def update_comment
    @comment = Comment.find(params[:comment_id])
    
    if params[:teacher_note].empty?
      @comment.teacher_note = ""
    else
      @comment.teacher_note = params[:teacher_note]
    end
    
    if @comment.save
      render :text => @comment.teacher_note
      # respond_to do |format|
      #         format.html {redirect_to(@comment.post) }
      #         format.xml { head :ok }
      #       end
    else
      flash[:error] = "Error updating comment: #{@comment.errors}"
      redirect_to(@comment.post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to(@comment.post)
  end
end