module CourseItemsHelper
  def refine_search_text(search_type)
    if search_type == "adopt"
  		"Refine my search for other teachers' LinguaZone resources"
  	else
  		"Refine my search"
  	end
  end
end