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
end