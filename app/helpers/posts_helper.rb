module PostsHelper
  
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
  
end

