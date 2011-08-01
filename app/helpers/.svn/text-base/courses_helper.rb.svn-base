module CoursesHelper
  
  def is_showing_or_can_add_to(type, showing_items, course)
    unless showing_items.empty?
      true
    else
      if current_user.nil?
        false
      else
        if current_user.role == "student"
          return false
        else
          if type == "audio_blog"
            if current_user.is_premium_subscriber?
              return is_teacher_for(course)
            else
              return false
            end
          end
          if showing_items.empty? or showing_items.nil?
            return is_teacher_for(course)
          else
            return true
          end
        end
      end
    end
  end

end