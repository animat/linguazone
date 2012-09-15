module MyCoursesHelper

  def display_link_to_course(c)
    str = "<p>"
    if c.archived?
      str << "Archived: "
    end
    str << link_to(c.name, course_path(c))
    str << "</p>"
    str.html_safe
  end

end