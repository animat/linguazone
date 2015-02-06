module PostsHelper
  
  def comment_class_according_to_user(user)
    if user.is_teacher?
      "teacher_comment"
    else
      "comment"
    end
  end
  
  def do_not_display_empty_note (comment)
    "style='display: none'".html_safe if comment.teacher_note.blank?
  end
  
  def display_empty_note (comment)
    "style='display: none'".html_safe unless comment.teacher_note.blank?
  end
  
  def saved_note(comment_id)
    render :update do |page|
      page.show comment_id+"_teacher_note"
      page.show "delete_"+comment_id+"_teacher_note_link"
      page.hide comment_id+"_new_teacher_note"
      page.hide "add_"+comment_id+"_teacher_note_link"
    end
  end
  
  def deleted_note(comment_id)
    render :update do |page|
      page.hide "delete_"+comment_id+"_teacher_note_link"
      page.visual_effect :slide_up, comment_id+"_teacher_note", :queue => :end
      page.visual_effect :appear, "add_"+comment_id+"_teacher_note_link", :queue => :end
    end
  end
  
  def display_optional_media(media)
    if media.source == "YouTube"
      YouTubeAddy.youtube_embed_url("http://youtu.be/#{media.embed}", 420, 315)
    end
  end
  
end

