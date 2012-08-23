module CourseRegistrationsHelper
  def single_line_authentications(user)
    str = ""
    unless user.has_generic_lz_email?
      str << "#{user.email}, "
    end
    user.authentications.each do |a|
      str << "<em>#{a.provider.titleize}</em>, "
    end
    str[0...-2].html_safe
  end
  
  def reset_password_button(user)
    str = ""
    unless user.has_generic_lz_email?
      str << link_to("Reset password", "#", :class => "reset_password_link")
    end
    str.html_safe
  end
end