module StudentsHelper
  
  def display_email_address
    if current_user.has_generic_lz_email?
			"<span class='not_on_file'>No email address saved</span>".html_safe
    else
			"<em>#{current_user.email}</em>".html_safe
		end
  end
  
  def set_empty_value_if_default
    if current_user.has_generic_lz_email?
      ""
    else
      current_user.email
    end
  end
  
end

